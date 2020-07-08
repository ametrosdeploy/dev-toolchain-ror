# frozen_string_literal: true

module LearnObjHandler
    # Needed to create Email Learn Object
    class Chat < LearnObjHandler::Base
      def initialize(args)
        super
      end
  
      def build_record
        @learning_object.objectable ||= ChatLearnObj.new
        @learning_object.objectable.assign_attributes(chat_params)
      end
  
      def chat_params
        return {} unless card?
  
        {
          learn_mod_id: params[:learn_mod_id]
        }.merge!(card_params)
      end
  
      def card_params
        {
          title: params[:card][:title],
          chat_character_id: params[:card][:chat_character_id],
          mentor_character_id: params[:card][:mentor_character_id]
        }
      end
    end
  end
  