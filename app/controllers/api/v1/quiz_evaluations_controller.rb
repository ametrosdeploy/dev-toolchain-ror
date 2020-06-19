# frozen_string_literal: true

# This handles the requests for Quiz evaluations
class Api::V1::QuizEvaluationsController < Api::V1::BaseController
  # POST /quiz_evaluations
  def create
    hsh = quiz_evaluation_params.merge(quiz_submitted: true)
    @quiz_evaluation = QuizEvaluation.create(hsh)
    hanlder = EvaluationHandler::Quiz::Evaluator.new(@quiz_evaluation)
    if hanlder.evaluate_and_save
      render json: serialize_rec(@quiz_evaluation), status: :created
    else
      render json: @quiz_evaluation.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :quiz_evaluations, 'Quiz Evaluation'
  swagger_api :create do
    summary 'Creates a new learner-quiz evaluation'
    notes 'Evaluates a learner quiz and send response'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'quiz_evaluation[user_learn_obj_id]', :string, :required,
          'user_learn_obj_id'
    param :form, 'quiz_evaluation[quiz_responses_attributes][]
          [quiz_question_id]', :string, :required, 'question'
    param :form, 'quiz_evaluation[quiz_responses_attributes][]
          [response]', :string, :optional,
          'response of (numeric, range, long ans qstn)'
    param :form, 'quiz_evaluation[quiz_responses_attributes][]
          [mcq_response_id]', :integer, :optional,
          'option_chosed for mcq'
    response :unauthorized
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  # Only allow a trusted parameter "white list" through.
  def quiz_evaluation_params
    params.require(:quiz_evaluation).permit(
      :user_learn_obj_id,
      quiz_responses_attributes: %i[quiz_question_id response mcq_response_id]
    )
  end

  def serializer
    QuizEvaluationSerializer
  end
end
