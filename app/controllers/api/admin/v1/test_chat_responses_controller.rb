# frozen_string_literal: true

# Controller for creating Test Chat Responses ...
class Api::Admin::V1::TestChatResponsesController < Api::Admin::V1::BaseController
    before_action :set_test_chat_response, only: %i[show update destroy]
    

    def show
        render json: serialize_rec(@test_chat_response)
    end

    def create
        @test_chat_response = TestChatResponse.new(test_chat_response_params)

        if @test_chat_response.save
            render json: serialize_rec(@test_chat_response), status: :created
        else
            render json: @test_chat_response.errors, status: :unprocessable_entity
        end
    end

    def update
        if @test_chat_response.update(test_chat_response_params)
            render json: serialize_rec(@test_chat_response)
        else
            render json: @test_chat_response.errors, status: :unprocessable_entity
        end
    end

    def destroy
     @test_chat_response.destroy
    end


    swagger_controller :test_chat_responses, 'Test Chat Response', resource_path:
      '/api/admin/v1/test_chat_responses'
   
=begin      
    swagger_api :create do
        summary 'Creates a new test chat response'
        notes 'Should be used to create a new test chat response (admin test message)'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'test_chat_response[test_chat_id]', :integer, :required, 'Test Chat ID'
        response :unauthorized
    end
=end

    swagger_api :show do
        summary 'Show test chat response'
        notes 'Should be used to show a test chat response (Character / mentor response from Watson Assistant)'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :integer, :required, 'Test chat response ID'
    end


    swagger_api :destroy do
        summary 'Destroy test chat response'
        notes 'Should be used to destroy a test chat response'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :integer, :required, 'test chat response ID'
    end



    private

    # Use callbacks to share common setup or constraints between actions.

    def set_test_chat_response
      @test_chat_response = TestChatMessage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def test_chat_response_params
        params.require(:test_chat_response).permit(:test_chat_id, :assistant_response, :mentor_character_id, :chat_character_id, :response_to_test_chat_message_id)
    end

    def responding_to_message 
        #
    end

    def serializer
        TestChatResponseSerializer
    end
  end
