# frozen_string_literal: true

module LearnObjHandler
  # Quiz Learn Object
  class Quiz < LearnObjHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @learning_object.objectable ||= QuizLearnObj.new
      @learning_object.objectable.assign_attributes(quiz_params)
    end

    def quiz_params
      return {} unless card?

      {
        title: params[:card][:title],
        description: params[:card][:description],
        score_view_type: params[:card][:score_view_type],
        overall_module_assessment_inclusion: module_eval_inclusion
      }
    end

    def overall_assessment_required
      params[:card][:overall_assessment_required]
    end

    def module_eval_inclusion
      params[:card][:overall_module_assessment_inclusion]
    end
  end
end
