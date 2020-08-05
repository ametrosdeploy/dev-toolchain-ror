# frozen_string_literal: true

class Api::V1::UserEmailIterationsController < Api::V1::BaseController
  before_action :set_user_email_evaluation, only: %i[create]

  # POST /user_email_iterations
  def create
    @user_email_iteration = @user_email_evaluation.user_email_iterations
                                                  .new(user_email_iteration_params)
    if @user_email_iteration.save
      evaluator = EvaluationHandler::Email::ResponseGenerator.new(response_generator_args)
      evaluator.generate
      render json: serialize_rec(@user_email_iteration), status: :created
    else
      render json: @user_email_iteration.errors, status: :unprocessable_entity
    end
 end

  swagger_controller :user_email_iterations, 'User Email Iterations'

  swagger_api :create do
    summary 'Evaluates the learner email submission and generate response'
    notes 'Should be used to evaluate a learner email and generate response'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'user_email_evaluation_id', :integer, :required,
          'user_email_evaluation Id'
    param :form, 'user_email_iteration[email]', :string, :required, 'Email'

    response :unauthorized
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_email_evaluation
    @user_email_evaluation = UserEmailEvaluation.find(params[:user_email_evaluation_id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_email_iteration_params
    params.require(:user_email_iteration).permit(:email)
  end

  def serializer
    Learner::UserEmailIterationSerializer
  end

  def response_generator_args
    {
      email_iteration: @user_email_iteration,
      email_evaluation: @user_email_evaluation,
      learn_obj: @user_email_evaluation.user_learn_obj.learning_object
    }
  end
end
