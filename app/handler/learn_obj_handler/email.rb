# frozen_string_literal: true

module LearnObjHandler
  class Email < LearnObjHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @learning_object = learn_mod.learning_objects
                                  .build(learning_object_params)
      @learning_object.objectable = EmailLearnObj.new(has_card? && email_params)
    end

    def email_params
      {
        title: params[:card][:title],
        description: params[:card][:description],
        to_character_ids: params[:card][:to_character_ids],
        cc_character_ids: params[:card][:cc_character_ids]
      }
    end
  end
end
