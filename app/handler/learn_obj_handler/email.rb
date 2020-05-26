# frozen_string_literal: true

module LearnObjHandler
  # Needed to create Email Learn Object
  class Email < LearnObjHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @learning_object.objectable ||= EmailLearnObj.new
      @learning_object.objectable.assign_attributes(email_params)
    end

    def email_params
      return {} unless card?

      {
        title: params[:card][:title],
        description: params[:card][:description],
        to_character_ids: params[:card][:to_character_ids],
        cc_character_ids: params[:card][:cc_character_ids],
        learn_mod_id: params[:learn_mod_id]
      }
    end
  end
end
