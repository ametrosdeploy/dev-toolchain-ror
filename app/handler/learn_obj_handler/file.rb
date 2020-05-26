# frozen_string_literal: true

module LearnObjHandler
  # Needed to create Email Learn Object
  class File < LearnObjHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @learning_object.objectable ||= FileLearnObj.new
      @learning_object.objectable.assign_attributes(file_params)
    end

    def file_params
      return {} unless card?

      {
        global_resource_id: params[:card][:global_resource_id]
      }
    end
  end
end
