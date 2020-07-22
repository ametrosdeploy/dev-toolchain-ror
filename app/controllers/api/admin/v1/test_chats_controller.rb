# frozen_string_literal: true

# Controller for creating assistant entities ...
class Api::Admin::V1::TestChatsController < Api::Admin::V1::BaseController
    before_action :set_chat_learning_object, only: %i[ create]
    before_action :set_test_chat, only: %i[show update destroy]

    LEARN_OBJ_ID = 'learning object ID'


    def show
        render json: serialize_rec(@test_chat)
    end

    def create
        @test_chat = UserChat.new(test_chat_params)

        if @test_chat.save
            render json: serialize_rec(@test_chat), status: :created
        else
            render json: @test_chat.errors, status: :unprocessable_entity
        end
    end

    def update
        if @test_chat.update(test_chat_params)
            render json: serialize_rec(@test_chat)
        else
            render json: @test_chat.errors, status: :unprocessable_entity
        end
    end

    def destroy
     @test_chat.destroy
    end


    swagger_controller :test_chats, 'Test Chats', resource_path:
      '/api/admin/v1/test_chats'

    swagger_api :create do
        summary 'Creates a new test chat'
        notes 'Should be used to create a new test chat'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'test_chat[chat_learn_obj_id]', :string, :required, 'Chat Learn Obj ID'
        param :form, 'test_chat[assistant_session_id]', :integer, :required, 'Assistant Session ID'
        param :form, 'test_chat[assistant_session_json]', :text, :required, 'Assistant session JSON'
        param :form, 'test_chat[character_starts_interaction]', :boolean, :optional, 'Character starts interaction'
        response :unauthorized
    end

    swagger_api :update do
        summary 'Updates a test chat'
        notes 'Should be used to update a test chat record'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'test_chat[chat_learn_obj_id]', :string, :required, 'Chat Learn Obj ID'
        param :form, 'test_chat[assistant_session_id]', :integer, :required, 'Assistant Session ID'
        param :form, 'test_chat[assistant_session_json]', :text, :required, 'Assistant session JSON'
        param :form, 'test_chat[character_starts_interaction]', :boolean, :optional, 'Character starts interaction'
        response :unauthorized
    end

    swagger_api :show do
        summary 'Show test chat'
        notes 'Should be used to show a test chat'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :string, :required, 'Test Chat ID'
    end

    swagger_api :destroy do
        summary 'Destroy test chat'
        notes 'Should be used to destroy a test chat'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :string, :required, 'Test Chat ID'
    end



    private

    # Use callbacks to share common setup or constraints between actions.

    def set_chat_learning_object
      @chat_learning_object = ChatLearnObj.find(
        params[:chat_learn_obj_id]
      )
    end

    def set_test_chat
      @test_chat = TestChat.find(params[:id])
      @learning_object ||= @test_chat.learning_object
    end

    # Only allow a trusted parameter "white list" through.
    def test_chat_params
        params.require(:test_chat).permit(:chat_learn_obj_id, :assistant_sessionid, :assistant_session_json, :character_starts_interaction, :user_id)
      end

    def serializer
        TestChatSerializer
    end
  end

  