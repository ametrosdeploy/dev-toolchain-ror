# frozen_string_literal: true

module AsstElementHandler
    # Quiz Learn Object
    class Assistant < AsstElementHandler::Base

      def initialize(args)
        super
        interaction_obj = @learning_object.objectable
        @name = interaction_obj[:title]
        @desc = interaction_obj[:description]
      end
  
      def create_assistant_session
        @response = @assistant_service.create_session(
          assistant_id: #assistant id here
        )

        # response err code handle ...
        return unless success?
  
        session_id = @response.result['session_id']
        UserChat.create(assistant_sessionid: session_id,
                        user_learn_obj_id: # value,
                        )
      end
    end
  end
  