# frozen_string_literal: true

# Controller for creating assistant entities ...
class Api::V1::UserChatMessagesController < Api::V1::BaseController
    before_action :set_user_chat_message, only: %i[show update destroy]
    

    def show
        render json: serialize_rec(@user_chat_message)
    end

    def create
        @user_chat_message = UserChatMessage.new(user_chat_message_params)

        if @user_chat_message.save
            set_learning_object
            set_assistant_id
            set_assistant_session_id
            send_learner_message_to_assistant
            render json: serialize_rec(@user_chat_message), status: :created
        else
            render json: @user_chat_message.errors, status: :unprocessable_entity
        end
    end

    def update
        if @user_chat_message.update(user_chat_message_params)
            render json: serialize_rec(@user_chat_message)
        else
            render json: @user_chat_message.errors, status: :unprocessable_entity
        end
    end

    def destroy
     @user_chat_message.destroy
    end


    swagger_controller :user_chats, 'User Chat Messages', resource_path:
      '/api/v1/user_chat_messages'
    
      swagger_api :create do
        summary 'Creates a new user chat message'
        notes 'Should be used to create a new user chat message (learner message)'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'user_chat_message[user_chat_id]', :string, :required, 'User Chat ID'
        param :form, 'user_chat_message[learner_message]', :text, :required, 'Learner message'
        response :unauthorized
    end

    swagger_api :show do
        summary 'Show user chat message'
        notes 'Should be used to show a user chat message'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :string, :required, 'User Chat Message ID'
    end

    swagger_api :destroy do
        summary 'Destroy user chat message'
        notes 'Should be used to destroy a user chat message'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :string, :required, 'User Chat Message ID'
    end



    private

    # Use callbacks to share common setup or constraints between actions.

    def set_user_chat_message
      @user_chat_message = UserChatMessage.find(params[:id])
    end

    def set_learning_object
        @learning_object = @user_chat_message.user_chat.user_learn_obj.learning_object
    end

    def set_assistant_id 
        @assistant_id = @user_chat_message.user_chat.user_learn_obj.learning_object.assistant_dialog_skill.asst_assistant_shell.assistant_id
    end

    def set_assistant_session_id 
        @assistant_session_id = @user_chat_message.user_chat.assistant_session_id
    end


    def send_learner_message_to_assistant
        learn_obj_hsh = { learn_mod: @learning_object.learn_mod,
            learning_object: @learning_object }
        assistant_user_chat_send = AsstElementHandler::Assistant.new(learn_obj_hsh)
        assistant_user_chat_send.send_learner_message_to_assistant(@user_chat_message.id, @assistant_id, @assistant_session_id, @user_chat_message.learner_message) 
    end

    # Only allow a trusted parameter "white list" through.
    def user_chat_message_params
        params.require(:user_chat_message).permit(:user_chat_id, :learner_message, :learner_id)
      end

    def serializer
        UserChatMessageSerializer
    end
  end
