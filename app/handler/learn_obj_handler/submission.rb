# frozen_string_literal: true

module LearnObjHandler
  # Needed to create Submission Learn Object
  class Submission < LearnObjHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @learning_object.objectable ||= SubmissionLearnObj.new
      @learning_object.objectable.assign_attributes(submission_params)
    end

    def submission_params
      return {} unless card?

      {
        has_text: params[:card][:has_text],
        has_file_upload: params[:card][:has_file_upload]
      }
    end
  end
end
