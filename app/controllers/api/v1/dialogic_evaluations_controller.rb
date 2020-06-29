# frozen_string_literal: true

# Controller that handles Evaluation for Dialogic LO
class Api::V1::DialogicEvaluationsController < Api::V1::BaseController
  before_action :set_dialogic_evaluation, only: %i[show update destroy]

  # GET /dialogic_evaluations
  def index
    @dialogic_evaluations = DialogicEvaluation.all

    render json: @dialogic_evaluations
  end

  # GET /dialogic_evaluations/1
  def show
    render json: @dialogic_evaluation
  end

  # POST /dialogic_evaluations
  def create
    @dialogic_evaluation = DialogicEvaluation.new(dialogic_evaluation_params)

    if @dialogic_evaluation.save
      render json: serialize_rec(@dialogic_evaluation), status: :created
    else
      render json: @dialogic_evaluation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dialogic_evaluations/1
  def update
    if @dialogic_evaluation.update(dialogic_evaluation_params)
      render json: @dialogic_evaluation
    else
      render json: @dialogic_evaluation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dialogic_evaluations/1
  def destroy
    @dialogic_evaluation.destroy
  end

  swagger_controller :dialogic_evaluations, 'Dialogic Evaluations'

  swagger_api :create do
    summary 'Creates a new learner-dialogic evaluation'
    notes 'Overall Dialogic Evaluation creation'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'dialogic_evaluation[user_learn_obj_id]', :string, :required,
          'user_learn_obj_id'
    param :form, 'dialogic_evaluation[repeat_count]', :integer, :required
    response :unauthorized
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dialogic_evaluation
    @dialogic_evaluation = DialogicEvaluation.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dialogic_evaluation_params
    params.require(:dialogic_evaluation).permit(:user_learn_obj_id,
                                                :repeat_count)
  end

  def serializer
    Learner::DialogicEvaluationSerializer
  end
end
