# frozen_string_literal: true

module EvaluationHandler
  module Quiz
    # For evaluating learner quiz submission ...
    class Evaluator
      def initialize(quiz_evaluation)
        @quiz_evaluation = quiz_evaluation
        if @quiz_evaluation.user_learn_obj_id.nil?
          @learn_obj = @quiz_evaluation.learning_object
        else
          @learn_obj = @quiz_evaluation.user_learn_obj.learning_object
        end
        @responses = @quiz_evaluation.quiz_responses
        @quiz_lo = @learn_obj.objectable
        @quiz_pt = 0
      end

      def evaluate_and_save
        @responses.each do |response|
          QuestionEvaluator.new(response, @learn_obj).evaluate_and_save_response
        end
        @quiz_pt = @responses.sum(:points_earned)
        @quiz_evaluation.update(evaluation_result)
      end

      def evaluation_result
        calculate_score
        hsh = {
          evaluated: true,
          point_type: @score_type,
          points: @score,
          quiz_complete: quiz_complete?
        }
        add_overall_assessment(hsh)
      end

      def add_overall_assessment(hsh)
        if @learn_obj.overall_assessment_required
          hsh.merge!(overall_assmnt_item_id:
            assessment_item&.id)
        end
        hsh
      end

      def assessment_item
        @learn_obj.overall_assmnt_items.find_by(
          'min_score <= :score AND max_score >= :score', { score: @score }
        )
      end

      def calculate_score
        @score_type = @quiz_lo.score_view_type
        @score = case @score_type
                 when 'numeric'
                   @quiz_pt
                 when 'percentage'
                   learner_percentage
                 when 'tally_correct_ans'
                   no_of_correct_ans
                 end
      end

      def learner_percentage
        (@quiz_pt.to_f / @quiz_lo.highest_possible_score.to_f) * 100
      end

      def no_of_correct_ans
        @responses.where(is_correct: true).count
      end

      def quiz_complete?
        @learn_obj.objectable.quiz_questions.count == @responses.length
      end
    end
  end
end
