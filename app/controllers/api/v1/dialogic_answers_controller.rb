# frozen_string_literal: true

class Api::V1::DialogicAnswersController < Api::V1::BaseController
  before_action :set_evaluation_obj, only: %i[index create next_questions]
  before_action :set_dialogic_answer, only: %i[show update destroy]

  # GET /dialogic_answers
  def index
    @dialogic_answers = @evaluation_obj.dialogic_answers
    render json: serialize_rec(@dialogic_answers)
  end

  # POST /dialogic_answers
  def create
    @dialogic_ans = @evaluation_obj.dialogic_answers.create(answer_hsh)
    hanlder = EvaluationHandler::Dialogic::QuestionEvaluator.new(@dialogic_ans)
    hanlder.evaluate
    if @dialogic_ans.save
      render json: serialize_rec(@dialogic_ans), status: :created
    else
      render json: @dialogic_ans.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :dialogic_answers, 'Dialogic Answers'

  swagger_api :index do
    summary 'Get learner answers with question'
    notes 'Should be used to get Get learner answers with question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'dialogic_evaluation_id', :integer, :required,
          'dialogic_evaluation_id'
    response :unauthorized
  end

  swagger_api :create do
    summary 'Creates and evaluates a learner answer to question'
    notes 'Should be used to creates and evaluates a learner answer to question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'dialogic_evaluation_id', :integer, :required,
          'dialogic_evaluation_id'
    param :form, 'dialogic_answer[dialogic_question_id]', :string, :required,
          'dialogic_question_id'
    param :form, 'dialogic_answer[question_variation_id]', :string, :required,
          'question_variation_id'
    param :form, 'dialogic_answer[answer]', :string, :required
    response :unauthorized
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dialogic_answer
    @dialogic_answer = DialogicAnswer.find(params[:id])
  end

  def set_evaluation_obj
    @evaluation_obj = DialogicEvaluation.find(params[:dialogic_evaluation_id])
  end

  # Only allow a trusted parameter "white list" through.
  def dialogic_answer_params
    params.require(:dialogic_answer)
          .permit(:dialogic_evaluation_id, :dialogic_question_id, :answer,
                  :question_variation_id, :evaluated)
  end

  def answer_hsh
    question_id = dialogic_answer_params[:dialogic_question_id]
    learner_attempt = @evaluation_obj.learner_attempt_of(question_id)
    dialogic_answer_params.merge(attempt: learner_attempt)
  end

  def serializer
    Learner::DialogicAnswerSerializer
  end
end
