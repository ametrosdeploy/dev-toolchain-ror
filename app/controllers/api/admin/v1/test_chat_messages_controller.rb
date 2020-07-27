# frozen_string_literal: true

# Controller for creating Test Chat Messages ...
class Api::Admin::V1::TestChatMessagesController < Api::Admin::V1::BaseController
    before_action :set_test_chat_message, only: %i[show update destroy]
    

    def show
        render json: serialize_rec(@test_chat_message)
    end

    def create
        @test_chat_message = TestChatMessage.new(test_chat_message_params)

        if @test_chat_message.save
            set_learning_object
            set_assistant_id
            set_assistant_session_id
            send_message_to_assistant

            render json: serialize_rec(@test_chat_message), status: :created
        else
            render json: @test_chat_message.errors, status: :unprocessable_entity
        end
    end

    def update
        if @test_chat_message.update(test_chat_message_params)
            render json: serialize_rec(@test_chat_message)
        else
            render json: @test_chat_message.errors, status: :unprocessable_entity
        end
    end

    def destroy
     @test_chat_message.destroy
    end


    swagger_controller :test_chat_messages, 'Test Chat Messages', resource_path:
      '/api/admin/v1/test_chat_messages'
    
      swagger_api :create do
        summary 'Creates a new test chat message'
        notes 'Should be used to create a new test chat message (admin test message)'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :form, 'test_chat_message[test_chat_id]', :integer, :required, 'Test Chat ID'
        param :form, 'test_chat_message[test_message]', :text, :required, 'Admin test message'
        response :unauthorized
    end

    swagger_api :show do
        summary 'Show test chat message'
        notes 'Should be used to show a test chat message'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :integer, :required, 'Test chat message ID'
    end

    swagger_api :destroy do
        summary 'Destroy test chat message'
        notes 'Should be used to destroy a test chat message'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :integer, :required, 'Test chat message ID'
    end



    private

    # Use callbacks to share common setup or constraints between actions.

    def set_test_chat_message
      @test_chat_message = TestChatMessage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def test_chat_message_params
        params.require(:test_chat_message).permit(:test_chat_id, :test_message)
    end

    def set_learning_object
        @learning_object = @test_chat_message.test_chat.chat_learn_obj.learning_object
    end

    def set_assistant_id 
        @assistant_id = @test_chat_message.test_chat.chat_learn_obj.learning_object.assistant_dialog_skill.asst_assistant_shell.assistant_id
    end

    def set_assistant_session_id 
        @assistant_session_id = @test_chat_message.test_chat.assistant_session_id
    end


    def send_message_to_assistant
        learn_obj_hsh = { learn_mod: @learning_object.learn_mod,
            learning_object: @learning_object }
        assistant_test_chat_send = AsstElementHandler::Assistant.new(learn_obj_hsh)
        assistant_test_chat_send.send_message_to_assistant(@test_chat_message.id, @assistant_id, @assistant_session_id, @test_chat_message.test_message) 
    end


    def serializer
        TestChatMessageSerializer
    end
  end
