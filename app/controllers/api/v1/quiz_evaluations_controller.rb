# frozen_string_literal: true

# This handles the requests for Quiz evaluations
class Api::V1::QuizEvaluationsController < Api::V1::BaseController
  before_action :set_evaluation, only: %i[update]

  # POST /quiz_evaluations
  def create
    hsh = quiz_evaluation_params.merge(quiz_submitted: true)
    @quiz_evaluation = QuizEvaluation.where(user_learn_obj_id: user_lo_id)
                                     .first_or_initialize
    if @quiz_evaluation.update(hsh)
      hanlder = EvaluationHandler::Quiz::Evaluator.new(@quiz_evaluation)
      hanlder.evaluate_and_save
      render json: serialize_rec(@quiz_evaluation), status: :created
    else
      render json: @quiz_evaluation.errors, status: :unprocessable_entity
    end
  end

  def update
    if !@quiz_evaluation&.quiz_complete?
      @quiz_evaluation.update(quiz_evaluation_params)
      hanlder = EvaluationHandler::Quiz::Evaluator.new(@quiz_evaluation)
      if hanlder.evaluate_and_save
        render json: serialize_rec(@quiz_evaluation), status: :created
      else
        render json: @quiz_evaluation.errors, status: :unprocessable_entity
      end
    else
      render json: quiz_complete, status: :unprocessable_entity
    end
  end

  def show
    @quiz_evaluation = QuizEvaluation.where(user_learn_obj_id: params[:id])
                                     .first
    if @quiz_evaluation&.quiz_complete?
      render json: detail_serializer.new(@quiz_evaluation).serializable_hash
    else
      render json: incomplete_quiz, status: :created
    end
  end

  swagger_controller :quiz_evaluations, 'Quiz Evaluation'
  swagger_api :create do
    summary 'Creates a new learner-quiz evaluation'
    notes 'Evaluates a learner quiz and send response'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'quiz_evaluation[user_learn_obj_id]', :string, :required,
          'user_learn_obj_id'
    param :form, 'quiz_evaluation[quiz_responses_attributes][][quiz_question_id]
          ', :string, :required, 'question'
    param :form, 'quiz_evaluation[quiz_responses_attributes][][response]',
          :string, :optional, 'response of (numeric, range, long ans qstn)'
    param :form, 'quiz_evaluation[quiz_responses_attributes][][mcq_response_id]
          ', :integer, :optional, 'option_chosed for mcq'
    response :unauthorized
  end

  swagger_api :update do
    summary 'Update a learner-quiz evaluation'
    notes 'Update a learner quiz and send response'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'Evaluation ID'
    param :form, 'quiz_evaluation[user_learn_obj_id]', :string, :required,
          'user_learn_obj_id'
    param :form, 'quiz_evaluation[quiz_responses_attributes][][id]', :string,
          :optional, 'quiz_response_id'
    param :form, 'quiz_evaluation[quiz_responses_attributes][][quiz_question_id]
          ', :string, :required, 'question'
    param :form, 'quiz_evaluation[quiz_responses_attributes][][response]',
          :string, :optional, 'response of (numeric, range, long ans qstn)'
    param :form, 'quiz_evaluation[quiz_responses_attributes][][mcq_response_id]
          ', :integer, :optional, 'option_chosed for mcq'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show quiz Overall response'
    notes 'Should be used to Show quiz Overall responses'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'user_learn_obj_id'
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
      quiz_responses_attributes: %i[id quiz_question_id response
                                    mcq_response_id]
    )
  end

  def serializer
    Learner::QuizEvaluationTrimmedSerializer
  end

  def detail_serializer
    Learner::QuizEvaluationSerializer
  end

  def user_lo_id
    quiz_evaluation_params[:user_learn_obj_id]
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
