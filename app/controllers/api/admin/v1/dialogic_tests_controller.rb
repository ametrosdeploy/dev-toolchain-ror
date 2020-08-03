# frozen_string_literal: true

# Controller that handles Dialogic Tests ...
class Api::Admin::V1::DialogicTestsController < Api::Admin::V1::BaseController
  before_action :set_dialogic_test, only: %i[show evaluate]
  before_action :set_dialogic_lo, only: %i[create specific_question_test]

  # GET /dialogic_tests
  def index
    @dialogic_tests = DialogicTest.all
    render json: serialize_rec(@dialogic_tests)
  end

  # GET /dialogic_tests/1
  def show
    render json: serialize_rec(@dialogic_test)
  end

  # POST /dialogic_tests
  def create
    @dialogic_test = @dialogic_lo.dialogic_tests.new(user_id: current_user.id)
    if @dialogic_test.save
      render json: serialize_rec(@dialogic_test), status: :created
    else
      render json: @dialogic_test.errors, status: :unprocessable_entity
    end
  end

  def evaluate
    hanlder = EvaluationHandler::Dialogic::Evaluator.new(@dialogic_test,
                                                         true)
    if hanlder.evaluate
      render json: serialize_rec(@dialogic_test)
    else
      render json: hanlder.full_messages, status: :created
    end
  end

  # DELETE /dialogic_tests/1
  def destroy
    @dialogic_test.destroy
  end

  def specific_question_test
    @dialogic_test = @dialogic_lo.dialogic_tests
                                 .create(user_id: current_user.id)
    @dialogic_test_answer = @dialogic_test.dialogic_answers.create(answer_hsh)                          
    hanlder = EvaluationHandler::Dialogic::QuestionEvaluator
                .new(@dialogic_test_answer, true)
    hanlder.evaluate
    if @dialogic_test_answer.save
      render json: answer_serialize(@dialogic_test_answer), status: :created
    else
      render json: @dialogic_test_answer.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :dialogic_tests, 'Dialogic Tests'

  swagger_api :evaluate do
    summary 'Final Evaluation of a Dialogic test interaction'
    notes 'Should be used for final evaluation/debrief'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'Dialogic Test ID'
  end

  swagger_api :create do
    summary 'Create a Dialogic Test Instance'
    notes 'Should be used to create a dialogic test instance'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'dialogic_learn_obj_id', :integer, :required,
          'Dialogic Learn Obj ID'
  end

  swagger_api :specific_question_test do
    summary 'Test a specific Question'
    notes 'Should be used to test a specific question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'dialogic_learn_obj_id', :integer, :required,
          'Dialogic Learn Obj ID'
    param :form, 'dialogic_test_answer[dialogic_question_id]', :string, :required,
          'dialogic_question_id'
    param :form, 'dialogic_test_answer[question_variation_id]', :string, :required,
          'question_variation_id'
    param :form, 'dialogic_test_answer[answer]', :string, :required
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dialogic_test
    @dialogic_test = DialogicTest.find(params[:id])
  end

  def set_dialogic_lo
    @dialogic_lo = DialogicLearnObj.find(params[:dialogic_learn_obj_id])
  end

  def serializer
    DialogicTestSerializer
  end

  def answer_serialize(data)
    DialogicTestAnswerSerializer.new(data).as_json['data']
  end

  def answer_hsh
    dialogic_test_answer_params.merge(attempt: 1)
  end

  # Only allow a trusted parameter "white list" through.
  def dialogic_test_answer_params
    params.require(:dialogic_test_answer).permit(:dialogic_question_id, :answer, 
                                                 :question_variation_id)
                                                 
  end
end
