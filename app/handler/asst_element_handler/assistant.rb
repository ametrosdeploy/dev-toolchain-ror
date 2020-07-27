# frozen_string_literal: true

module AsstElementHandler
  # Assistant session creation
  class Assistant < AsstElementHandler::Base

      def initialize(args)
        super
        interaction_obj = @learning_object.objectable
        @name = interaction_obj[:title]
        @desc = interaction_obj[:description]

        #@asst_assistant_shell = @learning_object.assistant_dialog_skill.asst_assistant_shell

        Rails.logger.debug "*** @asst_assistant_shell == #{@asst_assistant_shell}"
        Rails.logger.debug "*** @learning_object in assistant.rb initialize == #{@learning_object}"
      end

      def create_assistant_learner_session
        @response = @assistant_service.create_session(
          assistant_id: '' #assistant id here
        )

        # response err code handle ...
        return unless success?

        session_id = @response.result['session_id']
        UserChat.create(assistant_sessionid: session_id,
                        user_learn_obj_id: '' # value,
                        )
      end


      def create_assistant_test_session(test_chat_id, assistant_id) 
        
        Rails.logger.debug "*** test_chat_id in create_assistant_test_session = #{test_chat_id}"
        Rails.logger.debug "*** assistant_id in create_assistant_test_session = #{assistant_id}"

        @response = @assistant_v2_service.create_assistant_session(assistant_id)

        Rails.logger.debug "*** @response in assistant.rb = #{@response}"
        Rails.logger.debug "*** @assistant_v2 in assistant.rb = #{@assistant_v2}"
        Rails.logger.debug "*** @assistant in assistant.rb = #{@assistant}"
        Rails.logger.debug "*** @assistant_service in assistant.rb = #{@assistant_service}"
        
        return unless success? 

        session_id = @response.result['session_id']
        test_chat = TestChat.find(test_chat_id)
        test_chat.assistant_session_id = session_id
        test_chat.save!

        Rails.logger.debug "*** session_id in assistant.rb == #{session_id}"
      end
  end
end
