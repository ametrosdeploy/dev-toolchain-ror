# frozen_string_literal: true

module LearnObjHandler
  # Needed to create Text Learn Object
  class Text < LearnObjHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @learning_object.objectable ||= TextLearnObj.new
      @learning_object.objectable.assign_attributes(text_params)
    end

    def text_params
      return {} unless card?

      {
        title: params[:card][:title],
        description: params[:card][:description]
      }
    end
  end
end
