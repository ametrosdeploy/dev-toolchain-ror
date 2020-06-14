# frozen_string_literal: true

class Api::Admin::V1::QuizResponsesController < Api::Admin::V1::BaseController
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

  # def learner_response
  #   user_lo_id = quiz_response_params[:user_learn_obj_id]
  #   @quiz_response = @question.quiz_responses.find_by(user_learn_obj_id: user_lo_id)
  #   render json: serialize_rec(@quiz_response)
  # end

  swagger_controller :quiz_responses, 'QuizResponse', resource_path:
  '/api/admin/v1/quiz_learn_objs/:quiz_learn_obj_id/quiz_questions/:quiz_question_id/quiz_responses'

  swagger_api :create do
    summary 'Creates a new quiz response'
    notes 'Should be used to create quiz_responses'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_learn_obj_id', :integer, :required, 'Quiz LO ID'
    param :path, 'quiz_question_id', :string, :required, 'question ID'
    param :form, 'quiz_response[response]', :string, :optional,
          'response of (numeric, range, long ans qstn)'
    param :form, 'quiz_response[mcq_response_id]', :integer, :optional,
          'option_chosed for mcq'
    param :form, 'quiz_response[user_learn_obj_id]', :string, :required,
          'user_learn_obj_id'
    response :unauthorized
  end

  # swagger_api :show do
  #   summary 'Show quiz response'
  #   notes 'Should be used to Show a quiz response'
  #   param :header, :Authorization, :string, :required, 'Authorization'
  #   param :path, 'quiz_learn_obj_id', :integer, :required, 'Quiz LO ID'
  #   param :path, 'quiz_question_id', :string, :required, 'question ID'
  #   param :path, 'id', :string, :required, 'response id'
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_quiz_question
    @quiz_lo = QuizLearnObj.find(params[:quiz_learn_obj_id])
    @question = @quiz_lo.quiz_questions.find(params[:quiz_question_id])
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
