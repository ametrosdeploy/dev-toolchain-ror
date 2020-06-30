# frozen_string_literal: true

module EvaluationHandler
  module Dialogic
    # Evaluate individual question responses
    class QuestionEvaluator
      def initialize(answer_record)
        @answer_record = answer_record
        @question = @answer_record.dialogic_question
        @learn_obj = @question.dialogic_learn_obj.learning_object
        @asst_entities = @learn_obj.asst_entities.includes(
          asst_entity_values: :asst_entity_val_synonyms
        )
        @key_topics = @question.key_topics
        @entity_details = []
        @character_responses = []
        @follow_up_qstns = []
      end

      def learner_follow_up_response?
        @answer_record.follow_up_answer
      end

      def prepare_to_connect_asst
        learn_mod = @learn_obj.learn_mod
        @guid = learn_mod.asst_service_instance&.guid
        @skill_id = @learn_obj.assistant_dialog_skill&.skill_id
      end

      def sent_ans_to_watson
        prepare_to_connect_asst
        @assistant_service = AssistantService.new(@guid, @skill_id)
        response = @assistant_service.get_response(@answer_record.answer)
        result = response.result
        collect_entity_details(result)
      end

      def evaluate
        sent_ans_to_watson
        @key_topics.each do |key_topic|
          hsh = evaluate_for(key_topic)
          @answer_record.answer_key_topic_evaluations.create(hsh)
        end
        @answer_record.update(evaluation_hsh)
      end

      def evaluate_for(key_topic)
        topic_hit = @entity_details.find do |e|
          e[:key_topic_id] == key_topic.id
        end
        hsh = { key_topic_id: key_topic.id }
        prepare_key_topic_assmnt_hash(key_topic, topic_hit, hsh)
      end

      def prepare_key_topic_assmnt_hash(key_topic, topic_hit, hsh)
        if topic_hit.present?
          dialogic_assmnt_item = find_assmnt_item(key_topic,
                                                  topic_hit[:values])
          hsh = if dialogic_assmnt_item
                  prep_assmnt_hsh(hsh, dialogic_assmnt_item)
                else
                  prep_missed_assmnt_hsh(hsh, key_topic)
                end
        else
          hsh = prep_missed_assmnt_hsh(hsh, key_topic)
        end
        hsh
      end

      def find_assmnt_item(key_topic, values)
        assmnt_items = matching_assmnt_items(key_topic, values)
        selected_items = []
        assmnt_items.each do |item|
          required_values = item.required_key_topic_values
          selected_items << item if valid_assmnt?(values, required_values)
        end
        selected_items.first
      end

      def evaluation_hsh
        response = @character_responses.join('.')
        follow_up_qstn = @follow_up_qstns.join('.')
        { evaluated: true,
          character_response: response,
          follow_up_question: follow_up_qstn }
      end

      def prep_assmnt_hsh(hsh, assmnt_item)
        pts = assmnt_item.points
        add_assmnt_response(assmnt_item)
        pts = follow_up_pts(assmnt_item) if learner_follow_up_response?
        hsh.merge!(dialogic_assmnt_item_id: assmnt_item.id,
                   points_earned: pts)
      end

      def follow_up_pts(assmnt_item)
        assmnt_item.follow_up_question.points
      end

      def prep_missed_assmnt_hsh(hsh, key_topic)
        add_missed_response_of(key_topic)
        hsh.merge!(missed_assmnt_item_id: key_topic.missed_assmnt_item_id,
                   points_earned: 0)
      end

      def add_assmnt_response(dialogic_assmnt_item)
        all_responses = dialogic_assmnt_item.dialogic_responses
        @character_responses << pick_a_response_from(all_responses)
        return if learner_follow_up_response?

        @follow_up_qstns << dialogic_assmnt_item.follow_up_question.question
      end

      def add_missed_response_of(key_topic)
        missed_assmnt_item = key_topic.missed_assmnt_item
        if learner_follow_up_response?
          follow_up_responses = missed_assmnt_item.follow_up_responses
          @character_responses << pick_a_response_from(follow_up_responses)
        else
          char_responses = missed_assmnt_item.charcter_responses
          @character_responses << pick_a_response_from(char_responses)
          @follow_up_qstns << missed_assmnt_item.follow_up_question.question
        end
      end

      def pick_a_response_from(all_responses)
        random_index = rand(all_responses.count)
        all_responses[random_index]&.response
      end

      def collect_entity_details(rslt)
        entity_result(rslt).each do |key, value_arr|
          entity_name = key
          values = []
          value_arr.each do |value_info|
            values << value_info['value']
          end
          key_topic_id = find_key_topic_id(entity_name)
          @entity_details << { entity: entity_name, values: values,
                               key_topic_id: key_topic_id }
        end
      end

      def entity_result(result)
        entity_info = result['entities']
        entity_info.group_by { |h| h['entity'] }
      end

      def find_key_topic_id(entity)
        @key_topics.joins(:asst_entity)
                   .find_by('asst_entities.name = ?', entity)&.id
      end

      def matching_assmnt_items(key_topic, values)
        values_count = values.count
        key_topic.dialogic_assmnt_items.where(
          'value_count_min <= :hit_count AND value_count_max >= :hit_count',
          { hit_count: values_count }
        )
      end

      def valid_assmnt?(values, required_values)
        required_values.blank? || (required_values.present? &&
          all_required_values?(values, required_values))
      end

      def all_required_values?(values, required_values)
        ids = required_values.pluck(:key_topic_value_id)
        req_values = AsstEntityValue.find(ids).pluck(:value)
        (req_values - values).empty?
      end
    end
  end
end
