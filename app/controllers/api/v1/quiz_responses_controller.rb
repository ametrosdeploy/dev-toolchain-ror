# frozen_string_literal: true

class Api::V1::QuizResponsesController < Api::V1::BaseController
  before_action :set_quiz_question

  # POST /quiz_responses
  def create
    @quiz_response = @question.quiz_responses.new(quiz_response_params)
    hanlder = EvaluationHandler::QuizEvaluation.new(eval_hsh)
    if hanlder&.evaluate_and_save_response
      render json: serialize_rec(@quiz_response), status: :created
    else
      render json: @quiz_response.errors, status: :unprocessable_entity
    end
  end

  def quiz_final_resp
    user_lo_id = params[:user_learn_obj_id]
    @quiz_response = @question.quiz_responses
                              .find_by(user_learn_obj_id: user_lo_id)
    render json: serialize_rec(@quiz_response)
  end

  swagger_controller :quiz_responses, 'QuizResponse', resource_path:
  '/api/v1/quiz_responses'

  swagger_api :create do
    summary 'Creates a new quiz response'
    notes 'Should be used to create quiz_responses'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'quiz_question_id', :integer, :required, 'question ID'
    param :form, 'quiz_response[user_learn_obj_id]', :string, :required,
          'user_learn_obj_id'
    param :form, 'quiz_response[response]', :string, :optional,
          'response of (numeric, range, long ans qstn)'
    param :form, 'quiz_response[mcq_response_id]', :integer, :optional,
          'option_chosed for mcq'
    response :unauthorized
  end

  swagger_api :quiz_final_resp do
    summary 'Show quiz responses'
    notes 'Should be used to Show a quiz responses'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'user_learn_obj_id', :integer, :required, 'User LO ID'
    param :query, 'quiz_question_id', :integer, :required, 'Quiz Question ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_quiz_question
    @question = QuizQuestion.find(params[:quiz_question_id])
    @quiz_lo = @question.quiz_learn_obj
  end

  # Only allow a trusted parameter "white list" through.
  def quiz_response_params
    params.require(:quiz_response).permit(:response, :mcq_response_id,
                                          :user_learn_obj_id)
  end

  def serializer
    QuizResponseSerializer
  end

  def eval_hsh
    {
      quiz_lo: @quiz_lo,
      question: @question,
      response: @quiz_response
    }
  end
end
