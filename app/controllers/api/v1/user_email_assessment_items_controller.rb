# frozen_string_literal: true

class Api::V1::UserEmailAssessmentItemsController < Api::V1::BaseController
  before_action :set_user_email_assessment_item, only: %i[show]

  # GET /user_email_assessment_items

  def index
    @user_email_assessment_items = UserEmailAssessmentItem.where(user_email_evaluation_id: (params[:user_email_evaluation_id]))
    render json: serialize_rec(@user_email_assessment_items)
  end

  def show
    render json: serialize_rec(@user_email_assessment_item)
  end

  swagger_controller :user_email_assessment_items, 'User Email Assessment Items (Learner Email Debrief)'

  swagger_api :index do
    summary 'Get all learner email assessment items (debrief items) for a given User Email Evaluation'
    notes 'Should be used for Learner email debriefs'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'user_email_evaluation_id', :integer, :required, 'User Email Evaluation ID'
  end

  swagger_api :show do
    summary 'Shows a learner email assessment item'
    notes 'Should be used to show a learner email assessment item'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'user_email_assessment_item_id', :integer, :required, 'User Email Assessment Item ID'
    response :unauthorized
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_email_assessment_item
    @user_email_assessment_item = UserEmailAssessmentItem.find(params[:user_email_assessment_item_id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_email_assessment_item_params
    params.require(:user_email_assessment_item).permit(:email_assessment_item_id, :debrief_id, :debrief_content, :debrief_variant, :user_email_evaluation_id)
  end

  def serializer
    Learner::UserEmailAssessmentItemSerializer
  end

 
end

