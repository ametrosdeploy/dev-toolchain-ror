# frozen_string_literal: true

module EvaluationHandler
  module Dialogic
    # Evaluate individual question responses
    class QuestionEvaluator
      LAST_ATTEMPT = 4
      def initialize(ans, admin_test = false)
        @answer_record = ans
        @question = @answer_record.dialogic_question
        @learn_obj = @question.dialogic_learn_obj.learning_object
        @asst_entities = @learn_obj.asst_entities.includes(
          asst_entity_values: :asst_entity_val_synonyms
        )
        @key_topics = @question.key_topics
        @entity_details = []
        @character_responses = []
        @follow_up_qstns = []
        @is_admin_test = admin_test
        @evaluation_record = admin_test ? ans.dialogic_test : ans.dialogic_evaluation
      end

      def all_learners_combined
        ans = @evaluation_record.all_answers_records_for(@question.id)
                                &.pluck(:answer)
        ans&.join('.')
      end

      def collect_entity_hits_from_watson
        args = { learn_obj: @learn_obj,
                 qstn_key_topics: @key_topics,
                 answer: all_learners_combined }
        parser = ResponseParser.new(args)
        @entity_details = parser.parse
      end

      def evaluate
        collect_entity_hits_from_watson
        @key_topics.each do |key_topic|
          hsh = topic_evaluation_for(key_topic)
          kt_eval = if @is_admin_test
                      @answer_record.dialogic_test_kt_evals.create(hsh)
                    else
                      @answer_record.answer_key_topic_evaluations.create(hsh)
                    end
          add_topic_response_and_followups(kt_eval)
        end
        @answer_record.update(response_and_follow_ups)
      end

      def add_topic_response_and_followups(kt_eval)
        @itr_to_deliver = kt_eval.iteration_delivered
        assmnt = kt_eval.assessment
        responses = kt_eval.missed? ? assmnt.missed_responses : assmnt.dialogic_responses
        response_variations = filter_with_iterations(responses)
        @character_responses << pick_a_response_from(response_variations)
        return if @answer_record.attempt == LAST_ATTEMPT

        follow_ups = filter_with_iterations(assmnt.follow_up_questions)
        @follow_up_qstns << pick_a_followup_qstn_from(follow_ups)
      end

      def topic_evaluation_for(key_topic)
        args = { key_topic: key_topic,
                 key_topic_hit: filter_key_topic_hits_for(key_topic),
                 learner_attempt: @answer_record.attempt,
                 question: @question,
                 evaluation_record: @evaluation_record,
                 is_admin_test: @is_admin_test }
        kt_evaluator = KeyTopicEvaluator.new(args)
        kt_evaluator.evaluate
      end

      def filter_key_topic_hits_for(key_topic)
        @entity_details.find do |e|
          e[:key_topic_id] == key_topic.id
        end
      end

      def filter_with_iterations(records)
        records.where(iteration: @itr_to_deliver)
      end

      def pick_a_response_from(responses)
        random_index = rand(responses.count)
        responses[random_index]&.response
      end

      def pick_a_followup_qstn_from(questions)
        random_index = rand(questions.count)
        questions[random_index]&.question
      end

      def response_and_follow_ups
        response = @character_responses.join('.')
        follow_up_qstn = @follow_up_qstns.join('.')
        { evaluated: true,
          character_response: response,
          follow_up_question: follow_up_qstn }
      end
    end
  end
end
