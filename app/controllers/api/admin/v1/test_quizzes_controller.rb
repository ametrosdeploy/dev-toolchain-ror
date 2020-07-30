# frozen_string_literal: true

# Controller to test quiz response
class Api::Admin::V1::TestQuizzesController < Api::Admin::V1::BaseController
  before_action :set_evaluation, only: %i[final_evaluation destroy]
  QUIZ_EVAL_ID = 'Quiz Evaluation ID'

  def evaluation
    @quiz_evaluation = QuizEvaluation.create(learning_object_id: params[:lo_id])
    # Clear Old Test records
    QuizEvaluation.clear_test_record
    render json: { quiz_evaluation_id: @quiz_evaluation.id }
  end

  def final_evaluation
    if @quiz_evaluation&.quiz_complete?
      render json: serialize_rec(@quiz_evaluation)
    else
      render json: incomplete_quiz, status: :created
    end
  end

  # POST /quiz_evaluations
  def create
    hsh = quiz_evaluation_params.merge(quiz_submitted: true)
    @quiz_evaluation = QuizEvaluation.find(params[:quiz_evaluation_id])
    if @quiz_evaluation.update(hsh)
      hanlder = EvaluationHandler::Quiz::Evaluator.new(@quiz_evaluation)
      hanlder.evaluate_and_save
      render json: serialize_rec(@quiz_evaluation), status: :created
    else
      render json: @quiz_evaluation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @quiz_evaluation.destroy if !@quiz_evaluation.user_learn_obj_id?
  end

  swagger_controller :quiz_evaluations, 'Quiz Evaluation'

  swagger_api :evaluation do
    summary 'Get evaluation before testing quiz'
    notes 'Returns a new evaluation ID'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'lo_id', :integer, :required, 'Learning Object id'
    response :unauthorized
  end

  swagger_api :create do
    summary 'Creates a new learner-quiz evaluation'
    notes 'Evaluates a learner quiz and send response'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'quiz_evaluation_id', :integer, :required, 'quiz_evaluation_id'
    param :form, 'quiz_evaluation[quiz_responses_attributes][][quiz_question_id]
          ', :string, :required, 'question'
    param :form, 'quiz_evaluation[quiz_responses_attributes][][response]',
          :string, :optional, 'response of (numeric, range, long ans qstn)'
    param :form, 'quiz_evaluation[quiz_responses_attributes][][mcq_response_id]
          ', :integer, :optional, 'option_chosed for mcq'
    response :unauthorized
  end

  swagger_api :final_evaluation do
    summary 'Show quiz Overall response'
    notes 'Should be used to Show quiz Overall responses'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, QUIZ_EVAL_ID
  end

  swagger_api :destroy do
    summary 'Destroy test quiz evaluation'
    notes 'Should be used to destroy Destroy test quiz evaluation'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, QUIZ_EVAL_ID
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_evaluation
    @quiz_evaluation = QuizEvaluation.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def quiz_evaluation_params
    params.require(:quiz_evaluation).permit(
      :user_learn_obj_id,
      quiz_responses_attributes: %i[quiz_question_id response
                                    mcq_response_id]
    )
  end

  def serializer
    QuizEvaluationSerializer
  end

  def incomplete_quiz
    {
      message: I18n.t(:incomplete_quiz)
    }
  end

  def quiz_complete
    {
      message: I18n.t(:quiz_complete)
    }
  end
end
