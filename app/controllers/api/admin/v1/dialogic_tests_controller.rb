# frozen_string_literal: true

# Controller that handles Dialogic Tests ...
class Api::Admin::V1::DialogicTestsController < Api::Admin::V1::BaseController
  before_action :set_dialogic_test, only: %i[show evaluate]
  before_action :set_dialogic_lo, only: [:create]

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
end
