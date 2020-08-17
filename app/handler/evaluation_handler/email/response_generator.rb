# frozen_string_literal: true

module EvaluationHandler
  module Email
    # For evaluating learner email submission ...
    class ResponseGenerator
      include FormulaMatchChecker

      def initialize(args)
        @user_email_iteration = args[:email_iteration]
        @user_email_evaluation = args[:email_evaluation]
        @learn_obj = args[:learn_obj]
        @email_lo = @learn_obj.objectable
        @usr_iteration = @user_email_iteration.iteration
        @learner_email_txt = @user_email_iteration.email
        sanitize_response
      end

      def sanitize_response
        append_previous_emails
        @learner_email_txt.gsub!('\\n', '')
        @learner_email_txt.squish!
      end

      def append_previous_emails
        return unless iterations? && @usr_iteration > 1

        @learner_email_txt = learner_emails.join('. ')
      end

      def iterations?
        @email_lo.iteration_enabled &&
          @email_lo.iteration_level.present?
      end

      def learner_emails
        @user_email_evaluation.user_email_iterations.map(&:email)
      end

      def generate
        EnrichmentItemsCollector.new(@learner_email_txt,
                                     @user_email_evaluation,
                                     @learn_obj).collect
        @qa_checker = QaChecker.new(qa_checker_args)
        @qa_checker.track_qa_condition_hits
        find_matching_response_formula
        generate_response
      end

      def qa_checker_args
        {
          email_lo: @email_lo,
          email_iteration: @user_email_iteration
        }
      end

      def find_matching_response_formula
        @user_email_evaluation.response_formula_hits&.destroy_all
        email_responses = @email_lo.email_responses
        email_responses.each do |email_resp|
          email_resp.response_formulas.each do |formula|
            next unless matching_formula?(formula)

            track_response_formula_hits(formula)
          end
        end
      end

      def track_response_formula_hits(formula)
        @user_email_evaluation.response_formula_hits.create(
          response_formula_id: formula.id
        )
      end

      def responses_to_trigger
        formula_hits = @user_email_evaluation.response_formula_hits
        response_ids = formula_hits.map do |f|
          f.response_formula.email_response.id
        end
        response_ids.uniq!
        EmailResponse.where(id: response_ids)
      end

      def generate_response
        response_arr = responses_to_trigger
        to_character_ids = @email_lo.to_character_ids
        to_character_ids.each do |char_id|
          responses = response_arr.where(character_id: char_id)
          if responses.blank?
            binding.pry
            condition = @email_lo.qa_condition_for(char_id)
            @qa_checker.create_qa_condition_hits(condition)
          else
          response = get_resp_variation(responses)
          @user_email_iteration.user_email_iteration_responses
                               .create(response: response,
                                       character_id: char_id)
          end
          if @qa_checker.qa_condition_hit_for(char_id).present?
            @qa_checker.add_oof_response_and_interstitial_contents
          end

        end
      end

      def get_resp_variation(responses)
        responses_added = []
        responses.each do |response|
          variation = response.random_char_response_variation_for(@usr_iteration)
          @user_email_iteration.user_response_variations.create(
            char_response_variation_id: variation.id
          )
          responses_added << variation.response
        end
        responses_added.join('.')
      end

     

     

    end
  end
end
