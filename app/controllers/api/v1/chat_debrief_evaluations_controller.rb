# frozen_string_literal: true

# Controller that handles Chat Debrief Evaluation records for Chat LO
class Api::V1::ChatDebriefEvaluationsController < Api::V1::BaseController
    before_action :set_chat_debrief_evaluation, only: %i[show]

    def create
      @chat_debrief_evaluation = ChatDebriefEvaluation.new(chat_debrief_evaluation_params)

      if @chat_debrief_evaluation.save
          
          render json: serialize_rec(@chat_debrief_evaluation), status: :created
      else
          render json: @chat_debrief_evaluation.errors, status: :unprocessable_entity
      end
    end
  
    def show
      render json: serialize_rec(@chat_debrief_evaluation)
    end
  
=begin    swagger_controller :chat_debrief_evaluations, 'Chat Debrief Evaluations'
  
    
    swagger_api :create do
      summary 'Create Chat debrief evaluation record'
      notes 'Should be used to create chat debrief evaluation record'
      param :header, :Authorization, :string, :required, 'Authorization'
      param :form, 'chat_debrief_evaluation[chat_evaluation_id]', :integer, :required, 'Chat evaluation ID'
      param :form, 'chat_debrief_evaluation[assessment_label_id]', :integer, :required, 'Assessment label ID'
      param :form, 'chat_debrief_evaluation[chat_skill_assmnt_item_id]', :integer, :optional, 'Assessment item ID'
      param :form, 'chat_debrief_evaluation[chat_skill_assmnt_missed_id]', :integer, :optional, 'Assessment item missed ID'
      param :form, 'chat_debrief_evaluation[debrief_received]', :text, :optional, 'Debrief content received'
      param :form, 'chat_debrief_evaluation[assmnt_item_points]', :integer, :optional, 'Assessment item points'
    end
  
    swagger_api :show do
      summary 'Show Chat debrief evaluation record'
      notes 'Should be used to show a chat evaluation record'
      param :header, :Authorization, :string, :required, 'Authorization'
      param :path, 'id', :integer, :required, 'Chat Debrief Evaluation ID'
    end
=end

    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_chat_debrief_evaluation
      @chat_debrief_evaluation = ChatDebriefEvaluation.find(params[:id])
    end

    def chat_debrief_evaluation_params
      params.require(:chat_debrief_evaluation).permit(:user_chat_id, :assessment_label_id, :chat_skill_assmnt_item_id, :chat_skill_assmnt_missed_id, :debrief_received, :assmnt_item_points)
    end
  
    def serializer
      Learner::ChatDebriefEvaluationSerializer
    end

  
    
  end
  