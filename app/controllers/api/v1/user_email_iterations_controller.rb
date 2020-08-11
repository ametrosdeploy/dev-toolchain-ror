# frozen_string_literal: true

class Api::V1::UserEmailIterationsController < Api::V1::BaseController
  before_action :set_user_email_evaluation, only: %i[create index]
  before_action :set_user_email_iteration, only: %i[show]

  def index
    render json: serialize_rec(@user_email_evaluation.user_email_iterations.with_ordered)
  end

  # POST /user_email_iterations
  def create
    @user_email_iteration = @user_email_evaluation.user_email_iterations
                             .new(user_email_iteration_params)
    if @user_email_iteration.save
      evaluator = EvaluationHandler::Email::ResponseGenerator.new(response_generator_args)
      evaluator.generate
      assessor = EvaluationHandler::Email::AssessmentGenerator.new(response_generator_args)
      assessor.generate
      update_next_iteration_required
      render json: serialize_rec(@user_email_iteration), status: :created
    else
      render json: @user_email_iteration.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: serialize_rec(@user_email_iteration)
  end

  swagger_controller :user_email_iterations, 'User Email Iterations'

  swagger_api :index do
    summary 'List email iterations'
    notes 'Should be used to list existing email iterations.'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'user_email_evaluation_id', :integer, :required,
          'User Email Evaluation ID'
  end

  swagger_api :create do
    summary 'Evaluates the learner email submission and generate response'
    notes 'Should be used to evaluate a learner email and generate response'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'user_email_evaluation_id', :integer, :required,
          'user_email_evaluation Id'
    param :form, 'user_email_iteration[email]', :string, :required, 'Email'
    param :form, 'user_email_iteration[user_email_evaluation_attributes][email_subject]', :string, :optional,
          'Enter email subject'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Shows a learner email iteration item'
    notes 'Should be used to show a learner email iteration item'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'User Email Iteration ID'
    response :unauthorized
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_email_evaluation
    @user_email_evaluation = UserEmailEvaluation.find(params[:user_email_evaluation_id])
  end

  def set_user_email_iteration
    @user_email_iteration = UserEmailIteration.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_email_iteration_params
    params.require(:user_email_iteration)
          .permit(:email, :qa_condition_hit, user_email_evaluation_attributes:
                  [:email_subject])
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

  def update_next_iteration_required
    learn_obj = @user_email_evaluation.learning_object
    top_assmnt = learn_obj&.top_level_overall_assmnt_item
    if @user_email_iteration.overall_assmnt_item_id != top_assmnt.id
      email_obj = learn_obj.objectable
      if (email_obj.iteration_enabled &&
        @user_email_iteration.iteration < email_obj.iteration_level)
        @user_email_iteration.update(next_iteration_required: true)
      end
    end
  end

end
