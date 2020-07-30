# frozen_string_literal: true

module EvaluationHandler
  module Dialogic
    # Finds matching assessment & adds KT response, followp question & points...
    # 'result' attr will be answer_key_topic_evaluation ...
    class KeyTopicEvaluator
      def initialize(args)
        @key_topic = args[:key_topic]
        @learner_kt_match = args[:key_topic_hit]
        @learner_attempt = args[:learner_attempt]
        @question = args[:question]
        @evaluation_record = args[:evaluation_record]
        @result = { key_topic_id: @key_topic.id }
        @is_admin_test = args[:is_admin_test]
      end

      def evaluate
        if @learner_kt_match.present?
          dialogic_assmnt = find_assmnt_item(@learner_kt_match[:values])
          dialogic_assmnt ? prepare_result(dialogic_assmnt) : prepare_result
        else
          prepare_result
        end
        @result
      end

      def find_assmnt_item(values)
        assmnt_items = matching_assmnt_items(values)
        selected_items = []
        assmnt_items.each do |item|
          required_values = item.required_key_topic_values
          selected_items << item if valid_assmnt?(values, required_values)
        end
        selected_items.first
      end

      def matching_assmnt_items(values)
        values_count = values.count
        @key_topic.dialogic_assmnt_items.where(
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

      # if assmnt_item is not passed condsider as missed ...
      def prepare_result(assmnt_item = nil)
        missed = assmnt_item.blank?
        assmnt_item = @key_topic.missed_assmnt_item if missed
        if missed
          @result[:missed_assmnt_item_id] = assmnt_item.id
        else
          @result[:dialogic_assmnt_item_id] = assmnt_item.id
        end
        @result[:iteration_delivered] = iteration_to_deliver(assmnt_item,
                                                             missed)
        add_points_to_result(assmnt_item, missed)
      end

      def add_points_to_result(assmnt_item, missed)
        points = 0
        unless missed
          points = if @learner_attempt > 1
                     assmnt_item.follow_up_points
                   else
                     assmnt_item.points
                   end
        end
        @result[:points_earned] = points
      end

      # Finds the iteration to deliver ...
      def iteration_to_deliver(assmnt, is_missed)
        condition = previous_topic_evaluation_condition(assmnt, is_missed)
        kt_evals = if @is_admin_test
                     DialogicTestKtEval.where(condition)
                   else
                     AnswerKeyTopicEvaluation.where(condition)
                   end
        highest_itr = kt_evals&.pluck(:iteration_delivered)&.max
        highest_itr ? highest_itr + 1 : 1
      end

      def previous_topic_evaluation_condition(assmnt, is_missed)
        previous_ans_ids = @evaluation_record.all_answers_records_for(@question.id)
                                            &.pluck(:id)
        condition = { key_topic_id: @key_topic.id }
        if @is_admin_test
          condition[:dialogic_test_answer_id] = previous_ans_ids
        else
          condition[:dialogic_answer_id] = previous_ans_ids
        end
        if is_missed
          condition[:missed_assmnt_item_id] = assmnt.id
        else
          condition[:dialogic_assmnt_item_id] = assmnt.id
        end
        condition
      end
    end
  end
end
