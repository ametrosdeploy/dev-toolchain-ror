# frozen_string_literal: true

class Api::Admin::V1::DialogicTestAnswersController < Api::Admin::V1::BaseController
  before_action :set_dialogic_test, only: %i[index create]
  before_action :set_dialogic_test_answer, only: %i[show update destroy]

  # GET /dialogic_test_answers
  def index
    @dialogic_test_answers = @test_obj.dialogic_test_answers
    render json: serialize_rec(@dialogic_test_answers)
  end

  # GET /dialogic_test_answers/1
  def show
    render json: @dialogic_test_answer
  end

  # POST /dialogic_test_answers
  def create
    @dialogic_test_answer = @dialogic_test.dialogic_answers.create(answer_hsh)
    hanlder = EvaluationHandler::Dialogic::QuestionEvaluator.new(@dialogic_test_answer, true)
    hanlder.evaluate
    if @dialogic_test_answer.save
      render json: serialize_rec(@dialogic_test_answer), status: :created
    else
      render json: @dialogic_test_answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dialogic_test_answers/1
  def update
    if @dialogic_test_answer.update(dialogic_test_answer_params)
      render json: @dialogic_test_answer
    else
      render json: @dialogic_test_answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dialogic_test_answers/1
  def destroy
    @dialogic_test_answer.destroy
  end

  swagger_controller :dialogic_test_answers, 'Dialogic Test Answers'

  swagger_api :index do
    summary 'Get learner answers with question'
    notes 'Should be used to get Get learner answers with question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'dialogic_evaluation_id', :integer, :required,
          'dialogic_evaluation_id'
    response :unauthorized
  end

  swagger_api :create do
    summary 'Test answer evaluation'
    notes 'Should be used to test answer evaluation'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'dialogic_test_id', :integer, :required,
          'dialogic_test_id'
    param :form, 'dialogic_test_answer[dialogic_question_id]', :string, :required,
          'dialogic_question_id'
    param :form, 'dialogic_test_answer[question_variation_id]', :string, :required,
          'question_variation_id'
    param :form, 'dialogic_test_answer[answer]', :string, :required
    response :unauthorized
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dialogic_test_answer
    @dialogic_test_answer = DialogicTestAnswer.find(params[:id])
  end

  def set_dialogic_test
    @dialogic_test = DialogicTest.find(params[:dialogic_test_id])
  end

  # Only allow a trusted parameter "white list" through.
  def dialogic_test_answer_params
    params.require(:dialogic_test_answer).permit(:dialogic_question_id, :dialogic_test_id,
                                                 :answer, :question_variation_id)
  end

  def answer_hsh
    question_id = dialogic_test_answer_params[:dialogic_question_id]
    learner_attempt = @dialogic_test.learner_attempt_of(question_id)
    dialogic_test_answer_params.merge(attempt: learner_attempt)
  end

  def serializer
    DialogicTestAnswerSerializer
  end
end
