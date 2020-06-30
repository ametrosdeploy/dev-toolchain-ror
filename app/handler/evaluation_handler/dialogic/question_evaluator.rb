# frozen_string_literal: true

module EvaluationHandler
  module Dialogic
    # Evaluate individual question responses
    class QuestionEvaluator
      def initialize(answer_record)
        @answer_record = answer_record
        @answer = @answer_record.answer
        @question = @answer_record.dialogic_question
        @learn_obj = @question.dialogic_learn_obj.learning_object
        @asst_entities = @learn_obj.asst_entities.includes(
          asst_entity_values: :asst_entity_val_synonyms
        )
        @key_topics = @question.key_topics
        @entity_details = []
        @character_response = []
        @follow_up_qstn = []
      end

      def prepare_to_connect_asst
        learn_mod = @learn_obj.learn_mod
        @guid = learn_mod.asst_service_instance&.guid
        @skill_id = @learn_obj.assistant_dialog_skill&.skill_id
      end

      def evaluate
        sent_ans_to_watson
        @key_topics.each do |key_topic|
          topic_hit = @entity_details.find { |e| e[:key_topic_id] == key_topic.id }
          hsh = { key_topic_id: key_topic.id }
          if topic_hit.present?
            dialogic_assmnt_item = find_assmnt_item(key_topic, topic_hit[:values])
            hsh = if dialogic_assmnt_item
                    prep_assmnt_hsh(hsh, dialogic_assmnt_item)
                  else
                    prep_missed_assmnt_hsh(hsh, key_topic)
                  end
          else
            hsh = prep_missed_assmnt_hsh(hsh, key_topic)
          end
          @answer_record.answer_key_topic_evaluations.create(hsh)
        end
        @answer_record.update(evaluated: true)
      end

      def prep_assmnt_hsh(hsh, dialogic_assmnt_item)
        hsh.merge!(dialogic_assmnt_item_id: dialogic_assmnt_item.id,
                   points_earned: dialogic_assmnt_item.points)
      end

      def add_response_for_key_topic(dialogic_assmnt_item)
        all_responses = dialogic_assmnt_item.dialogic_responses
        random_index = rand(all_responses.count)
        character_response << @all_responses[random_index].pluck(:response)
      end

      def add_key_topic_missed_response(_dialogic_assmnt_item)
        all_responses = missed_assmnt_item.missed_responses
        random_index = rand(all_responses.count)
        character_response << @all_responses[random_index].pluck(:response)
      end

      def prep_missed_assmnt_hsh(hsh, key_topic)
        hsh.merge!(missed_assmnt_item_id: key_topic.missed_assmnt_item_id,
                   points_earned: 0)
      end

      # def random_pick_response_and_follow_up_question(hsh)
      #   if hsh[:dialogic_assmnt_item_id].present?

      #   elsif hsh[:missed_assmnt_item_id].present?
      #   end
      # end

      def sent_ans_to_watson
        prepare_to_connect_asst
        @assistant_service = AssistantService.new(@guid, @skill_id)
        response = @assistant_service.get_response(@answer)
        result = response.result
        collect_entity_details(result)
      end

      def collect_entity_details(result)
        entity_info = result['entities']
        entity_hsh = entity_info.group_by { |h| h['entity'] }
        entity_hsh.each do |key, value_arr|
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

      def find_key_topic_id(entity)
        @key_topics.joins(:asst_entity)
                   .find_by('asst_entities.name = ?', entity)&.id
      end

      def find_assmnt_item(key_topic, values)
        values_count = values.count
        assmnt_items = key_topic.dialogic_assmnt_items
                                .where('value_count_min <= :hit_count AND value_count_max >= :hit_count',
                                       { hit_count: values_count })
        selected_items = []
        assmnt_items.each do |item|
          required_values = item.required_key_topic_values
          selected_items << item if valid_assmnt?(values, required_values)
        end
        selected_items.first
      end

      def valid_assmnt?(values, required_values)
        required_values.blank? || (required_values.present? &&
          has_all_required_values?(values, required_values))
      end

      def has_all_required_values?(values, required_values)
        ids = required_values.pluck(:key_topic_value_id)
        req_values = AsstEntityValue.find(ids).pluck(:value)
        (req_values - values).empty?
      end
    end
  end
end
