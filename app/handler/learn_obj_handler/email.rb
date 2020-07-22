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
        learn_mod_id: params[:learn_mod_id]
      }.merge!(card_params)
    end

    def card_params
      to_character_ids = params[:card][:to_character_ids]
      {
        title: params[:card][:title],
        email_body: params[:card][:email_body],
        to_character_ids: to_character_ids,
        cc_character_ids: params[:card][:cc_character_ids],
        iteration_enabled: params[:card][:iteration_enabled] || false,
        iteration_level: params[:card][:iteration_level] || false,
        iteration_explanation: params[:card][:iteration_explanation],
        qa_conditions_attributes: qa_attr(to_character_ids)
      }
    end

    def qa_attr(to_character_ids)
      return if to_character_ids.blank?

      to_character_ids.map { |c| { character_id: c } }
    end
  end
end
