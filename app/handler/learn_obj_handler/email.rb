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
      email_lo_args = {
        title: params[:card][:title],
        email_body: params[:card][:email_body],
        to_character_ids: to_character_ids,
        cc_character_ids: params[:card][:cc_character_ids],
        iteration_enabled: params[:card][:iteration_enabled] || false,
        iteration_level: params[:card][:iteration_level],
        iteration_explanation: params[:card][:iteration_explanation]
      }
      add_qa_records_if_any(to_character_ids, email_lo_args)
    end

    def add_qa_records_if_any(to_character_ids, email_lo_args)
      new_qa_records = qa_record_updates(to_character_ids)
      if new_qa_records.present?
        email_lo_args[:qa_conditions_attributes] = new_qa_records
      end
      email_lo_args
    end

    def qa_record_updates(to_character_ids)
      unless @learning_object.new_record?
        email_lo = @learning_object.objectable
        qa_exist_chars = email_lo.qa_conditions&.pluck(:character_id)
        to_delete_ids = qa_exist_chars - (qa_exist_chars & to_character_ids)
        email_lo.qa_conditions.where(character_id: to_delete_ids)&.destroy_all
        to_character_ids -= qa_exist_chars
      end
      to_character_ids.map do |c|
        { character_id: c, ooto_response: ooto_default(c) }
      end
    end

    def ooto_default(character_id)
      character = WorldOrgCharacter.find(character_id).character
      "Hello, \n Thank you for your message. I am currently out of the office,
       with no email access. I will be returning on #{Date.tomorrow} \n
       I will respond to your emails as soon as possible upon my return.\n \n
       Kind Regards,\n #{character.full_name}"
    end
  end
end
