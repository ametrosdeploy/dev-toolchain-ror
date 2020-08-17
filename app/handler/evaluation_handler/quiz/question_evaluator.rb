# frozen_string_literal: true

module EvaluationHandler
  module Quiz
    # Evaluate individual question responses
    class QuestionEvaluator
      def initialize(response, learn_obj)
        @response_record = response
        @question = response.quiz_question
        @response = learner_answer
        @learn_obj = learn_obj
      end

      def prepare_to_connect_asst
        learn_mod = @learn_obj.learn_mod
        @guid = learn_mod.asst_service_instance&.guid
        @skill_id = @learn_obj.assistant_dialog_skill&.skill_id
      end

      def learner_answer
        if @question.multiple_choice?
          @response_record.mcq_response_id
        else
          @response_record.response
        end
      end

      def evaluate_and_save_response
        @response_record.update(evaluation_hsh)
        add_watson_response_json if @question.long_answer?
      end

      def add_watson_response_json
        @response_record.watson_response = @watson_response&.result
      end

      def evaluation_hsh
        hsh = {}
        feedback = @question.quiz_feedback
        hsh[:is_correct] = correct_response?
        if hsh[:is_correct]
          hsh[:points_earned] = @question.points
          hsh[:feedback_received] = feedback&.right_ans_feedback
        else
          hsh[:points_earned] = 0
          hsh[:feedback_received] = feedback&.wrong_ans_feedback
        end
        hsh[:evaluated] = true
        hsh
      end

      def float_answer
        @response.to_f
      end

      def correct_response?
        case @question.question_type
        when 'multiple_choice'
          check_mcq_response
        when 'numeric'
          check_number_ans
        when 'range'
          check_ans_within_range
        when 'long_answer'
          send_to_ai_for_ans_check
        end
      end

      def check_mcq_response
        correct_option = @question.mcq_options.find_by(is_correct: true)
        @response == correct_option&.id
      end

      def check_number_ans
        float_answer == @question.numeric_answer.answer
      end

      def check_ans_within_range
        range = @question.range_answer
        float_answer.between?(range.low_range, range.high_range)
      end

      def send_to_ai_for_ans_check
        prepare_to_connect_asst
        @assistant_service = AssistantService.new(@guid, @skill_id)
        intent = "question-#{@question.id} "
        response = @response.prepend(intent)
        @watson_response = @assistant_service.get_response(response&.squish)
        asst_res = @watson_response.result['output']['text']&.first
        asst_res == 'Correct'
      end
    end
  end
end
