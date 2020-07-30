# frozen_string_literal: true

# Controller that handles Evaluation for Chat LO
class Api::V1::ChatEvaluationsController < Api::V1::BaseController
    before_action :set_chat_evaluation, only: %i[show evaluate]
  
    def evaluate
      handler = EvaluationHandler::Chat::Evaluator.new(@chat_evaluation)
  
      if handler.evaluate
        render json: serialize_rec(@chat_evaluation)
      else
        render json: incomplete_chat, status: :created
      end
    end

    def create
      @chat_evaluation = ChatEvaluation.new(chat_evaluation_params)

      if @chat_evaluation.save
          
          render json: serialize_rec(@chat_evaluation), status: :created
      else
          render json: @chat_evaluation.errors, status: :unprocessable_entity
      end
    end
  
    def show
      render json: serialize_rec(@chat_evaluation)
    end
  
    swagger_controller :dialogic_evaluations, 'Chat Evaluations'
  
    swagger_api :evaluate do
      summary 'Evaluates Chat interaction'
      notes 'Should be used to evaluate chat interaction'
      param :header, :Authorization, :string, :required, 'Authorization'
      param :path, 'id', :integer, :required, 'Chat Evaluation ID'
    end

    swagger_api :create do
      summary 'Create Chat evaluation record'
      notes 'Should be used to create chat evaluation record'
      param :header, :Authorization, :string, :required, 'Authorization'
      param :form, 'chat_evaluation[user_chat_id]', :integer, :required, 'User chat ID'
    end
  
    swagger_api :show do
      summary 'Show Chat evaluation record'
      notes 'Should be used to show a chat evaluation record'
      param :header, :Authorization, :string, :required, 'Authorization'
      param :path, 'id', :integer, :required, 'Chat Evaluation ID'
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_chat_evaluation
      @chat_evaluation = ChatEvaluation.find(params[:id])
    end
  
    def serializer
      Learner::ChatEvaluationSerializer
    end

    def chat_evaluation_params
      params.require(:chat_evaluation).permit(:user_chat_id, :overall_assmnt_item_id, :complete)
    end
  
    def incomplete_chat
      {
        message: I18n.t(:incomplete_chat)
      }
    end
  end
  