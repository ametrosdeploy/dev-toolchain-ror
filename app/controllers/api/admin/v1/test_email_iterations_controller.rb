# frozen_string_literal: true

# Controller for Testing Email Interactions
class Api::Admin::V1::TestEmailIterationsController < Api::Admin::V1::BaseController
  before_action :create_and_set_email_evaluation, only: %i[create]

  # POST /test_email_iterations
  def create
    @test_email_iteration = @evaluation_rec.test_email_iterations
                                           .new(test_email_params)
    if @test_email_iteration.save
      EvaluationHandler::Email::ResponseGenerator.new(generator_args).generate
      render json: serialize_rec(@test_email_iteration), status: :created
    else
      render json: @test_email_iteration.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :test_email_iterations, 'Test Email Interactions'

  swagger_api :create do
    summary 'Evaluates the test email submission and generate response'
    notes 'Should be used to evaluate a test email and generate response'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'email_learn_obj_id', :integer, :required,
          'Email learn obj Id'
    param :form, 'test_email_iteration[email]', :string, :required, 'Email'
    response :unauthorized
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def create_and_set_email_evaluation
    @evaluation_rec = TestEmailEvaluation.create(
      user_id: current_user.id,
      email_learn_obj_id: params[:email_learn_obj_id]
    )
  end

  # Only allow a trusted parameter "white list" through.
  def test_email_iteration_params
    params.require(:test_email_iteration).permit(:email, :iteration)
  end

  def test_email_params
    test_email_iteration_params.merge(iteration: 1)
  end

  def serializer
    TestEmailIterationSerializer
  end

  def generator_args
    {
      email_iteration: @test_email_iteration,
      email_evaluation: @evaluation_rec,
      learn_obj: @evaluation_rec.email_learn_obj.learning_object
    }
  end
end
