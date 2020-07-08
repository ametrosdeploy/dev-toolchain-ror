# frozen_string_literal: true

# Controller that handles Evaluation for Dialogic LO
class Api::V1::DialogicEvaluationsController < Api::V1::BaseController
  before_action :set_dialogic_evaluation, only: %i[show update destroy]

  def show
    hanlder = EvaluationHandler::Dialogic::Evaluator.new(@dialogic_evaluation)

    if hanlder.evaluate
      render json: serialize_rec(@dialogic_evaluation)
    else
      render json: incomplete_dialogic, status: :created
    end
  end

  swagger_controller :dialogic_evaluations, 'Dialogic Evaluations'

  swagger_api :show do
    summary 'Show Dialogic Overall response'
    notes 'Should be used to get Overall dialogic responses'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'Dialogic Evaluation ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dialogic_evaluation
    @dialogic_evaluation = DialogicEvaluation.find(params[:id])
  end

  def serializer
    Learner::DialogicEvaluationSerializer
  end

  def incomplete_dialogic
    {
      message: I18n.t(:incomplete_dialogic)
    }
  end
end
