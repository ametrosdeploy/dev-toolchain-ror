# frozen_string_literal: true

# Controller for creating user chats ...
class Api::V1::UserChatsController < Api::V1::BaseController
    #before_action :set_user_learning_object, only: %i[ create]
    before_action :set_user_chat, only: %i[show update destroy evaluate]

    LEARN_OBJ_ID = 'learning object ID'

    def evaluate
        handler = EvaluationHandler::Chat::Evaluator.new(@user_chat)
    
        if handler.evaluate
          render json: serialize_rec(@user_chat)
        else
          render json: incomplete_chat, status: :created
        end
    end


    def show
        render json: serialize_rec(@user_chat)
    end

    def create
        @user_chat = UserChat.new(user_chat_params)

        if @user_chat.save
            set_learning_object
            set_assistant_id
            create_assistant_learner_session
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

    swagger_api :evaluate do
        summary 'Evaluates user chat interaction'
        notes 'Should be used to evaluate user chat interaction'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :integer, :required, 'User Chat ID'
    end

    swagger_api :create do
        summary 'Creates a new user chat'
        notes 'Should be used to create a new user chat session'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'user_chat[user_learn_obj_id]', :integer, :required, 'User Learn Obj ID'
        response :unauthorized
    end

=begin
    swagger_api :update do
        summary 'Updates a user chat'
        notes 'Should be used to update a user chat record'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'user_chat[user_learn_obj_id]', :string, :required, 'User Learn Obj ID'
        param :form, 'user_chat[assistant_session_id]', :integer, :required, 'Assistant Session ID'
        param :form, 'user_chat[assistant_session_json]', :string, :required, 'Assistant session JSON'
        param :form, 'user_chat[character_starts_interaction]', :boolean, :optional, 'Character starts interaction'
        response :unauthorized
    end
=end

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

    def set_learning_object
        @learning_object = @user_chat.user_learn_obj.learning_object
    end

    def set_assistant_id 
        @assistant_id = @user_chat.user_learn_obj.learning_object.assistant_dialog_skill.asst_assistant_shell.assistant_id
    end

    def set_assistant_api_key 
        @assistant_api_key = @user_chat.user_learn_obj.learning_object.assistant_dialog_skill.asst_assistant_shell.api_key
    end

    def create_assistant_learner_session
        learn_obj_hsh = { learn_mod: @learning_object.learn_mod,
            learning_object: @learning_object }
        assistant_user_session = AsstElementHandler::Assistant.new(learn_obj_hsh)
        assistant_user_session.create_assistant_learner_session(@user_chat.id, @assistant_id)
    end

    # Only allow a trusted parameter "white list" through.
    def user_chat_params
        params.require(:user_chat).permit(:user_learn_obj_id, :assistant_session_id, :assistant_session_json, :character_starts_interaction, :overall_assmnt_item_id, :complete, :skills_score_hash, :skills_missed)
    end

    def serializer
        UserChatSerializer
    end

    def incomplete_chat
        {
          message: I18n.t(:incomplete_chat)
        }
    end
  end
