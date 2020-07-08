# frozen_string_literal: true

# Controller for creating assistant entities ...
<<<<<<< HEAD
class Api::Admin::V1::UserChatsController < Api::Admin::V1::BaseController
    before_action :set_learning_object, only: %i[index create]
    before_action :set_user_chat, only: %i[show update destroy]

    LEARN_OBJ_ID = 'learning object ID'

=======
class Api::V1::UserChatsController < Api::V1::BaseController
    before_action :set_learning_object, only: %i[index create ]
  
    before_action :set_user_chat, only: %i[show update destroy]
  
    LEARN_OBJ_ID = 'learning object ID'
  
>>>>>>> Adds controllers and serializers for ChatSkill, ChatSkillAssmntItem, ChatSkillAssmntMissed
    def index
        @user_chats = UserChat.all
        render json: @user_chats
    end

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
<<<<<<< HEAD


=======
  
  
>>>>>>> Adds controllers and serializers for ChatSkill, ChatSkillAssmntItem, ChatSkillAssmntMissed
    swagger_controller :user_chats, 'User Chats', resource_path:
      '/api/v1/user_chats'

    swagger_api :create do
        summary 'Creates a new user chat'
        notes 'Should be used to create a new user chat'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'user_chat[user_learn_obj_id]', :string, :required, 'User Learn Obj ID'
        param :form, 'user_chat[assistant_sessionid]', :integer, :required, 'Assistant Session ID'
        param :form, 'user_chat[assistant_session_json]', :strig, :required, 'Assistant session JSON'
        response :unauthorized
    end

    swagger_api :update do
        summary 'Updates a user chat'
        notes 'Should be used to update a user chat record'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'user_chat[user_learn_obj_id]', :string, :required, 'User Learn Obj ID'
        param :form, 'user_chat[assistant_sessionid]', :integer, :required, 'Assistant Session ID'
        param :form, 'user_chat[assistant_session_json]', :strig, :required, 'Assistant session JSON'
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

    def set_learning_object
      @learning_object = LearningObject.find(
        params[:learning_object_id]
      )
    end
    
    def set_user_chat
      @user_chat = UserChat.find(params[:id])
      @learning_object ||= @user_chat.user_learning_object.learning_object
    end

    # Only allow a trusted parameter "white list" through.
    def user_chat_params
        params.require(:user_chat).permit(:user_learn_obj_id, :assistant_sessionid, :assistant_session_json, :character_starts_interaction)
      end

    def serializer
        UserChatSerializer
    end
  end
