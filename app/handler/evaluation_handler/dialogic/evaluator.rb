# frozen_string_literal: true

module EvaluationHandler
  module Dialogic
    # For evaluating dialogic interaction ...
    class Evaluator
      def initialize(dialogic_evaluation, test_interaction = false)
        @test_interaction = test_interaction
        @dialogic_evaluation = dialogic_evaluation
        @answers = @dialogic_evaluation.dialogic_answers
        @learning_object = learning_object
        @overall_points = 0
        @errors = []
      end

      def errors(msg)
        @errors << msg
      end

      def full_messages
        @errors.join(', ')
      end

      def learning_object
        if @test_interaction
          @dialogic_evaluation.dialogic_learn_obj
                              .learning_object
        else
          @dialogic_evaluation.user_learn_obj
                              .learning_object
        end
      end

      def all_questions
        learning_object.objectable.dialogic_questions
                       .includes([:key_topics])
      end

      def evaluate
        @dialogic_evaluation.dialogic_debrief_evaluations.destroy_all
        all_questions.each do |qstn|
          Rails.logger.info("** Checking answer for qus (ID: #{qstn.id})")
          qstn_answers = @answers.where(dialogic_question_id: qstn.id)
          choose_key_topic_assmnt(qstn, qstn_answers)
        end
        if @learning_object.overall_assessment_required
          find_and_save_overall_assmnt
        end
        @dialogic_evaluation.update(complete: true)
      rescue StandardError => e
        errors(e.message)
      end

      def choose_key_topic_assmnt(qstn, answers)
        qstn.key_topics.each do |topic|
          kt_evals = answers.map do |ans|
            ans.answer_key_topic_evaluations.find_by(key_topic_id: topic.id)
          end.compact
          Rails.logger.info("** Ans KT eval records for topicID(#{topic.id}) -
            - (IDs: #{kt_evals.pluck(:id)})")
          eval_choosed, pts_earned = best_evaluation_for_key_topic(kt_evals)
          Rails.logger.info("** eval_choosed - (#{eval_choosed&.id})")
          Rails.logger.info("** pts_earned - (#{pts_earned})")
          @dialogic_evaluation.dialogic_debrief_evaluations.create(
            debrief_eval_hsh(eval_choosed, pts_earned, topic)
          )
        end
      end

      def debrief_eval_hsh(evl, points_earned, topic)
        hsh = { key_topic_id: topic.id,
                dialogic_question_id: topic.dialogic_question_id,
                kt_points: points_earned }
        if evl.missed_assmnt_item.present?
          hsh.merge!(key_topic_missed: true,
                     debrief_received: pick_debrief(evl.missed_assmnt_item))
        else
          assmnt = evl.dialogic_assmnt_item
          hsh.merge!(key_topic_missed: false,
                     assessment_label_id: assmnt.assessment_label.id,
                     debrief_received: pick_debrief(assmnt))
        end
        hsh = add_debrief_suggestions(hsh, assmnt)
        hsh
      end

      def add_debrief_suggestions(hsh, assmnt)
        contents = assmnt.adaptive_contents
        if contents.present?
          results = contents.map do |content|
            { adaptive_content_id: content.id }
          end
          hsh[:dialogic_debrief_suggested_contents_attributes] = results
        end
        hsh
      end

      def pick_debrief(assmnt)
        debriefs = assmnt.debriefs
        random_index = rand(debriefs.count)
        debrief_record = debriefs[random_index]
        debrief_record&.content
      end

      def best_evaluation_for_key_topic(kt_evaluations)
        Rails.logger.info("** Finds - best_evaluation_for_key_topic")
        eval_ids = kt_evaluations.pluck(:id)
        evals_records = topic_eval_class.constantize.where(id: eval_ids)
        Rails.logger.info("** evals_records :: #{evals_records.pluck(:id)}")
        eval_choosed = evals_records.order(:id).last
        Rails.logger.info("** eval_choosed :: #{eval_choosed&.id}")
        kt_points_earned = evals_records.pluck(:points_earned)
                                        &.compact&.max
        [eval_choosed, kt_points_earned]
      end

      def topic_eval_class
        @test_interaction ? 'DialogicTestKtEval' : 'AnswerKeyTopicEvaluation'
      end

      def find_and_save_overall_assmnt
        evals = @dialogic_evaluation.dialogic_debrief_evaluations
        learner_total_pts = evals.sum(:kt_points)
        overall_assmnt = @learning_object.overall_assmnt_items.find_by(
          'min_score <= :points AND max_score >= :points',
          { points: learner_total_pts }
        )
        return unless overall_assmnt

        @dialogic_evaluation.update(overall_assmnt_item_id: overall_assmnt&.id,
                                    overall_points: learner_total_pts)
      end
    end
  end
end
