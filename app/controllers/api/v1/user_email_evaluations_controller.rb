# frozen_string_literal: true

class Api::V1::UserEmailEvaluationsController < Api::V1::BaseController
  before_action :set_user_email_evaluation, only: %i[show]

  # GET /user_email_evaluations/1
  def show
    render json: @user_email_evaluation
  end

  # POST /user_email_evaluations
  def create
    @user_email_evaluation = UserEmailEvaluation.new(user_email_evaluation_params)

    if @user_email_evaluation.save
      render json: @user_email_evaluation, status: :created, location: @user_email_evaluation
    else
      render json: @user_email_evaluation.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :user_email_evaluations, 'User Email Evaluation'

  swagger_api :show do
    summary 'Show User Email Evaluation'
    notes 'Should be used to show User Email Evaluation'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'User Email Evaluation ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_email_evaluation
    @user_email_evaluation = UserEmailEvaluation.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_email_evaluation_params
    params.require(:user_email_evaluation).permit(:user_learn_obj_id, :overall_score)
  end
end
