# frozen_string_literal: true

module AsstElementHandler
  # Assistant session creation
  class Assistant < AsstElementHandler::Base

      def initialize(args)
        super
        interaction_obj = @learning_object.objectable
        @name = interaction_obj[:title]
        @desc = interaction_obj[:description]

      end

      def create_assistant_learner_session(user_chat_id, assistant_id) 
        @response = @assistant_v2_service.create_assistant_session(assistant_id)

        # response err code handle ...
        return unless success?

        session_id = @response.result['session_id']

        user_chat = UserChat.find(user_chat_id)
        user_chat.assistant_session_id = session_id 
        user_chat.save! 

      end

      def send_message_to_assistant(user_chat_message_id, assistant_id, session_id, message)

        @response = @assistant_v2_service.send_message_to_assistant(assistant_id, session_id, message)

        # response err code handle ...
        return unless success?

        user_chat_response_json = @response.result
        user_chat_message = UserChatMessage.find(user_chat_message_id)

        Rails.logger.debug "*** debug user_chat_response_json in assistant.rb line 74 --> #{user_chat_response_json}"

        if user_chat_response_json.blank? 
          user_chat_response_text = "Blank result from Watson"
        else 
          if user_chat_response_json['output']['generic'].present?
            user_chat_response_text = user_chat_response_json['output']['generic'][0]['text']
          else  
            user_chat_response_text = "No character response from Watson - make some dialog node changes"
          end
        end 

        user_chat_response_text = user_chat_response_json['output']['generic'][0]['text']
        chat_character_id = user_chat_message.user_chat.user_learn_obj.learning_object.objectable.chat_character_id

        @user_chat_response = UserChatMessage.create(
                                response_to_user_chat_message_id: user_chat_message_id,
                                user_chat_id: user_chat_message.user_chat_id,
                                response_result_json: user_chat_response_json, 
                                message: user_chat_response_text, 
                                assistant_response: true
                              )

      end


      def create_assistant_test_session(test_chat_id, assistant_id) 
        @response = @assistant_v2_service.create_assistant_session(assistant_id)

        return unless success? 

        session_id = @response.result['session_id']

        test_chat = TestChat.find(test_chat_id)
        test_chat.assistant_session_id = session_id
        test_chat.save!

      end


      def send_test_message_to_assistant(test_chat_message_id, assistant_id, session_id, message)

        @response = @assistant_v2_service.send_test_message_to_assistant(test_chat_message_id, assistant_id, session_id, message)

        # response err code handle ...
        return unless success?

        test_chat_response_json = @response.result
        test_chat_message = TestChatMessage.find(test_chat_message_id)

        Rails.logger.debug "*** debug test_chat_response_json in assistant.rb line 74 --> #{test_chat_response_json}"

        if test_chat_response_json.blank? 
          test_chat_response_text = "Blank result from Watson"
        else 
          if test_chat_response_json['output']['generic'].present?
            test_chat_response_text = test_chat_response_json['output']['generic'][0]['text']
          else  
            test_chat_response_text = "No character response from Watson - make some dialog node changes"
          end
        end  
        
        chat_character_id = test_chat_message.test_chat.chat_learn_obj.chat_character_id

        @test_chat_response = TestChatMessage.create(
                                response_to_test_chat_message_id: test_chat_message_id,
                                test_chat_id: test_chat_message.test_chat_id,
                                response_result_json: test_chat_response_json, 
                                message: test_chat_response_text, 
                                assistant_response: true
                              )

      end
  end
end
