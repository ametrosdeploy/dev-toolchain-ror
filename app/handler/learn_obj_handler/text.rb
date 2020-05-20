# frozen_string_literal: true

module LearnObjHandler
  class Text < LearnObjHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @learning_object = learn_mod.learning_objects
                                  .build(learning_object_params)
      @learning_object.objectable = TextLearnObj.new(has_card? && text_params)
    end

    def text_params
      {
        title: params[:card][:title],
        description: params[:card][:description]
      }
    end
  end
end
