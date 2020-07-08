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
<<<<<<< HEAD

      def create_assistant_session
        @response = @assistant_service.create_session(
          assistant_id: '' #assistant id here
=======
  
      def create_assistant_session
        @response = @assistant_service.create_session(
          assistant_id: #assistant id here
>>>>>>> Adds controllers and serializers for ChatSkill, ChatSkillAssmntItem, ChatSkillAssmntMissed
        )

        # response err code handle ...
        return unless success?
<<<<<<< HEAD

        session_id = @response.result['session_id']
        UserChat.create(assistant_sessionid: session_id,
                        user_learn_obj_id: '' # value,
=======
  
        session_id = @response.result['session_id']
        UserChat.create(assistant_sessionid: session_id,
                        user_learn_obj_id: # value,
>>>>>>> Adds controllers and serializers for ChatSkill, ChatSkillAssmntItem, ChatSkillAssmntMissed
                        )
      end
  end
<<<<<<< HEAD
<<<<<<< HEAD
=======
end
>>>>>>> Rubocop changes
=======
end
>>>>>>> Rubocop changes
