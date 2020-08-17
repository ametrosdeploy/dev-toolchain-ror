module EvaluationHandler
  module Email
    # For evaluating learner email submission ...
    class QaChecker
      include FormulaMatchChecker

      def initialize(args)
        @email_lo = args[:email_lo]
        @user_email_iteration = args[:email_iteration]
      end

      def track_qa_condition_hits
        qa_conditions = @email_lo.qa_conditions
        qa_conditions.each do |qa_condition|
          qa_formula_hit_ids = []
          qa_condition.qa_formulas.each do |formula|
            next unless matching_formula?(formula)

            qa_formula_hit_ids << formula.id
          end
          next if qa_formula_hit_ids.blank?

          create_qa_condition_hits(qa_condition, formula_hit_ids)
        end
      end

      def create_qa_condition_hits(condition, formula_hit_ids = [])
        blank_response_hit = formula_hit_ids.blank? ? true : false
        @user_email_iteration.qa_condition_hits.create(
          user_email_iteration_id: @user_email_iteration.id,
          qa_condition_id: condition.id,
          qa_formula_hits: formula_hit_ids,
          blank_response_hit: blank_response_hit
        )
      end

      def qa_condition_hit_for(char_id)
        @user_email_iteration.qa_condition_hits.find_by(
          qa_condition_id: char_qa_condition(char_id).id
        )
      end

      def char_qa_condition(char_id)
        @email_lo.qa_condition_for(char_id)
      end

      def add_out_of_office_response(char_id)
        oof_response = char_qa_condition(char_id).ooto_response
        @user_email_iteration.user_email_iteration_responses
                             .create(response: oof_response,
                                     character_id: char_id,
                                     is_ootd_response: true)
      end

    end
  end
end