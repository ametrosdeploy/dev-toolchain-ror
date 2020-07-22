# frozen_string_literal: true

# Controller for creating assistant entities ...
class Api::V1::UserChatsController < Api::V1::BaseController
    before_action :set_user_learning_object, only: %i[ create]
    before_action :set_user_chat, only: %i[show update destroy]

    LEARN_OBJ_ID = 'learning object ID'

    

    def show
        render json: serialize_rec(@user_chat)
    end

    def create
        @user_chat = UserChat.new(user_chat_params)

        if @user_chat.save
            render json: serialize_rec(@user_chat), status: :created
        else
            render json: @user_chat.errors, status: :unprocessable_entity
        end
    end

    def update
        if @user_chat.update(user_chat_params)
            render json: serialize_rec(@user_chat)
        else
            render json: @user_chat.errors, status: :unprocessable_entity
        end
    end

    def destroy
     @user_chat.destroy
    end


    swagger_controller :user_chats, 'User Chats', resource_path:
      '/api/v1/user_chats'

    swagger_api :create do
        summary 'Creates a new user chat'
        notes 'Should be used to create a new user chat'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'user_chat[user_learn_obj_id]', :string, :required, 'User Learn Obj ID'
        param :form, 'user_chat[assistant_sessionid]', :integer, :required, 'Assistant Session ID'
        param :form, 'user_chat[assistant_session_json]', :string, :required, 'Assistant session JSON'
        param :form, 'user_chat[character_starts_interaction]', :boolean, :optional, 'Character starts interaction'
        param :form, 'user_chat[testing]', :boolean, :optional, 'Admin test chat'
        response :unauthorized
    end

    swagger_api :update do
        summary 'Updates a user chat'
        notes 'Should be used to update a user chat record'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'user_chat[user_learn_obj_id]', :string, :required, 'User Learn Obj ID'
        param :form, 'user_chat[assistant_sessionid]', :integer, :required, 'Assistant Session ID'
        param :form, 'user_chat[assistant_session_json]', :string, :required, 'Assistant session JSON'
        param :form, 'user_chat[character_starts_interaction]', :boolean, :optional, 'Character starts interaction'
        param :form, 'user_chat[testing]', :boolean, :optional, 'Admin testing chat'
        response :unauthorized
    end

    swagger_api :show do
        summary 'Show user chat'
        notes 'Should be used to show a user chat'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :string, :required, 'User Chat ID'
    end

    swagger_api :destroy do
        summary 'Destroy user chat'
        notes 'Should be used to destroy a user chat'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :string, :required, 'User Chat ID'
    end



    private

    # Use callbacks to share common setup or constraints between actions.

    def set_user_learning_object
      @user_learning_object = UserLearnObj.find(
        params[:user_learn_obj_id]
      )
    end

    def set_user_chat
      @user_chat = UserChat.find(params[:id])
      @learning_object ||= @user_chat.user_learn_obj.learning_object
    end

    # Only allow a trusted parameter "white list" through.
    def user_chat_params
        params.require(:user_chat).permit(:user_learn_obj_id, :assistant_sessionid, :assistant_session_json, :character_starts_interaction)
      end

    def serializer
        UserChatSerializer
    end
  end
