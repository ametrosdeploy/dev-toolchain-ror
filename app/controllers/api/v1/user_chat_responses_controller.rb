# frozen_string_literal: true

# Controller for creating user chat responses ...
class Api::V1::UserChatResponsesController < Api::V1::BaseController
    before_action :set_user_chat, only: %i[show update destroy]


    def show
        render json: serialize_rec(@user_chat_response)
    end

    def create
        @user_chat_response = UserChatMessage.new(user_chat_response_params)

        if @user_chat_response.save
            render json: serialize_rec(@user_chat_response), status: :created
        else
            render json: @user_chat_response.errors, status: :unprocessable_entity
        end
    end

    def update
        if @user_chat_response.update(user_chat_response_params)
            render json: serialize_rec(@user_chat)
        else
            render json: @user_chat_response.errors, status: :unprocessable_entity
        end
    end

    def destroy
     @user_chat_response.destroy
    end


    swagger_controller :user_chats, 'User Chat Responses', resource_path:
      '/api/v1/user_chat_responses'

    

    swagger_api :show do
        summary 'Show user chat response'
        notes 'Should be used to show a user chat response'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :string, :required, 'User Chat Response ID'
    end

    swagger_api :destroy do
        summary 'Destroy user chat response'
        notes 'Should be used to destroy a user chat response'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :string, :required, 'User Chat Response ID'
    end



    private

    # Use callbacks to share common setup or constraints between actions.

    def set_user_chat_response
      @user_chat_response = UserChatMessage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_chat_response_params
        params.require(:user_chat).permit(:user_chat_id, :assistant_response, :mentor_character_id, :chat_character_id, :response_to_user_chat_message_id, :response_result_json)
      end

    def serializer
        UserChatResponseSerializer
    end
  end
