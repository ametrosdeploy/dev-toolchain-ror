# frozen_string_literal: true

# Controller for Testing Email Interaction
class Api::Admin::V1::TestEmailIterationsController < Api::Admin::V1::BaseController
  before_action :set_test_email_iteration, only: [:show, :update, :destroy]

  # GET /test_email_iterations
  def index
    @test_email_iterations = TestEmailIteration.all

    render json: @test_email_iterations
  end

  # GET /test_email_iterations/1
  def show
    render json: @test_email_iteration
  end


  # POST /test_email_iterations
  def create
    @test_email_evaluation = TestEmailEvaluation.create(user_id: current_user.id,
                                                        email_learn_obj_id: params[:email_learn_obj_id])
    @test_email_iteration = @test_email_evaluation.test_email_iterations
                             .new(test_email_params)                                            
    if @test_email_iteration.save
      evaluator = EvaluationHandler::Email::ResponseGenerator.new(response_generator_args)
      evaluator.generate
      render json: serialize_rec(@test_email_iteration), status: :created
    else
      render json: @test_email_iteration.errors, status: :unprocessable_entity
    end
 end

  # PATCH/PUT /test_email_iterations/1
  def update
    if @test_email_iteration.update(test_email_iteration_params)
      render json: @test_email_iteration
    else
      render json: @test_email_iteration.errors, status: :unprocessable_entity
    end
  end

  # DELETE /test_email_iterations/1
  def destroy
    @test_email_iteration.destroy
  end

  swagger_controller :test_email_iterations, 'Test Email Iterations'

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
    def set_test_email_iteration
      @test_email_iteration = TestEmailIteration.find(params[:id])
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

    def response_generator_args
      {
        email_iteration: @test_email_iteration,
        email_evaluation: @test_email_evaluation,
        learn_obj: @test_email_evaluation.email_learn_obj.learning_object
      }
    end
end
