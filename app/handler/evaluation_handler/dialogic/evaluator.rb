# frozen_string_literal: true

module EvaluationHandler
  module Dialogic
    # For evaluating dialogic interaction ...
    class Evaluator
      def initialize(dialogic_evaluation)
        @dialogic_evaluation = dialogic_evaluation
        @answers = @dialogic_evaluation.dialogic_answers
        @learning_object = learning_object
        @overall_points = 0
        @missed_assmnt_order = missed_label_order
      end

      def missed_label_order
        @learning_object.assessment_scheme
                        .assessment_labels.count + 1
      end

      def learning_object
        @dialogic_evaluation.user_learn_obj
                            .learning_object
      end

      def all_questions
        learning_object.objectable.dialogic_questions
      end

      def evaluate
        all_questions.each do |qstn|
          qstn_answers = @answers.where(dialogic_question_id: qstn.id)
          choose_key_topic_assmnt(qstn, qstn_answers)
        end
        find_and_save_overall_assmnt
      end

      def choose_key_topic_assmnt(qstn, answers)
        qstn.key_topics.each do |topic|
          kt_evals = answers.map do |ans|
            ans.answer_key_topic_evaluations.find_by(key_topic_id: topic.id)
          end.compact
          eval_choosed, pts_earned = best_evaluation_for_key_topic(kt_evals)
          DialogicDebriefEvaluation.create(
            debrief_eval_hsh(eval_choosed, pts_earned, topic)
          )
        end
      end

      def debrief_eval_hsh(evl, points_earned, topic)
        hsh = { dialogic_evaluation_id: @dialogic_evaluation.id,
                key_topic_id: topic.id,
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
        hsh
      end

      def pick_debrief(assmnt)
        debriefs = assmnt.debriefs
        random_index = rand(debriefs.count)
        debrief_record = debriefs[random_index]
        debrief_record&.content
      end

      def best_evaluation_for_key_topic(kt_evaluations)
        # Max ans will be 2
        first_eval = kt_evaluations.first
        eval_choosed = first_eval
        kt_points_earned = first_eval.points_earned
        second_eval = kt_evaluations&.second
        if second_eval && (find_order(second_eval) < find_order(first_eval))
          eval_choosed = second_eval
          if kt_points_earned < second_eval.points_earned
            kt_points_earned = second_eval.points_earned
          end
        end
        [eval_choosed, kt_points_earned]
      end

      def find_order(eval)
        if eval.dialogic_assmnt_item
          eval.dialogic_assmnt_item.assessment_label.order
        else
          @missed_assmnt_order
        end
      end

      def find_and_save_overall_assmnt
        evals = @dialogic_evaluation.dialogic_debrief_evaluations
        learner_total_pts = evals.sum(:kt_points)
        overall_assmnt_item = @learning_object.overall_assmnt_items.find_by(
          'min_score <= :points AND max_score >= :points',
          { points: learner_total_pts }
        )
        @dialogic_evaluation.update(
          overall_assmnt_item_id: overall_assmnt_item&.id,
          overall_points: learner_total_pts
        )
      end
    end
  end
end
