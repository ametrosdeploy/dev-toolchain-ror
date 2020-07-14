# frozen_string_literal: true

# This handles the requests for user_submission
class Api::V1::UserSubmissionsController < Api::V1::BaseController
  before_action :set_user_submission, only: %i[show update]

  def show
    render json: serialize_rec(@user_submission)
  end

  def create
    user_lo_id = params[:user_learn_obj_id]
    @user_submission = UserSubmission.where(user_learn_obj_id: user_lo_id)
                                     .first_or_initialize
    if @user_submission.update(user_submission_params)
      render json: serialize_rec(@user_submission), status: :created
    else
      render json: @user_submission.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user_submission.update(user_submission_params)
      render json: serialize_rec(@user_submission)
    else
      render json: @user_submission.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :user_submission, 'User Submission'
  swagger_api :create do
    summary 'Creates a new User Submission'
    notes 'Should be used to create User Submission'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'user_submission[user_learn_obj_id]', :string, :required,
          'user_learn_obj_id'
    param :form, 'user_submission[attachment]', :string, :required, 'attachment'
    param :form, 'user_submission[user_text]', :string, :optional, 'user_text'
    response :unauthorized
  end

  swagger_api :update do
    summary 'Update User Submission'
    notes 'Should be used to update User Submission'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'User Learn Obj ID'
    param :form, 'user_submission[user_learn_obj_id]', :string, :required,
          'user_learn_obj_id'
    param :form, 'user_submission[attachment]', :string, :required, 'attachment'
    param :form, 'user_submission[user_text]', :string, :optional, 'user_text'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show User Submission'
    notes 'Should be used to Show User Submission'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'User Learn Obj ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_submission
    @user_submission = UserSubmission.where(user_learn_obj_id: params[:id])
                                     .first
  end

  # Only allow a trusted parameter "white list" through.
  def user_submission_params
    params.require(:user_submission).permit(:user_learn_obj_id, :attachment,
                                            :user_text)
  end

  def serializer
    Learner::UserSubmissionSerializer
  end
end
