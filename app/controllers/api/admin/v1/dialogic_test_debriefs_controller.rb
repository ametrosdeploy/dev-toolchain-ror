# frozen_string_literal: true

class Api::Admin::V1::DialogicTestDebriefsController < Api::Admin::V1::BaseController
  before_action :set_dialogic_test_debrief, only: %i[show update destroy]

  # GET /dialogic_test_debriefs
  def index
    @dialogic_test_debriefs = DialogicTestDebrief.all

    render json: @dialogic_test_debriefs
  end

  # GET /dialogic_test_debriefs/1
  def show
    render json: @dialogic_test_debrief
  end

  # POST /dialogic_test_debriefs
  def create
    @dialogic_test_debrief = DialogicTestDebrief.new(dialogic_test_debrief_params)

    if @dialogic_test_debrief.save
      render json: @dialogic_test_debrief, status: :created, location: @dialogic_test_debrief
    else
      render json: @dialogic_test_debrief.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dialogic_test_debriefs/1
  def update
    if @dialogic_test_debrief.update(dialogic_test_debrief_params)
      render json: @dialogic_test_debrief
    else
      render json: @dialogic_test_debrief.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dialogic_test_debriefs/1
  def destroy
    @dialogic_test_debrief.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dialogic_test_debrief
    @dialogic_test_debrief = DialogicTestDebrief.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dialogic_test_debrief_params
    params.require(:dialogic_test_debrief).permit(:dialogic_test_id, :key_topic_id, :assessment_label_id, :debrief_received, :key_topic_missed, :kt_points)
  end
end
