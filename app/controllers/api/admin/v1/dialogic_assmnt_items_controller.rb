# frozen_string_literal: true

class Api::Admin::V1::DialogicAssmntItemsController < Api::Admin::V1::BaseController
  before_action :set_dialogic_assmnt_item, only: %i[show update destroy]

  # GET /dialogic_assmnt_items
  def index
    @dialogic_assmnt_items = DialogicAssmntItem.all

    render json: @dialogic_assmnt_items
  end

  # GET /dialogic_assmnt_items/1
  def show
    render json: @dialogic_assmnt_item
  end

  # POST /dialogic_assmnt_items
  def create
    @dialogic_assmnt_item = DialogicAssmntItem.new(dialogic_assmnt_item_params)

    if @dialogic_assmnt_item.save
      render json: @dialogic_assmnt_item, status: :created, location: @dialogic_assmnt_item
    else
      render json: @dialogic_assmnt_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dialogic_assmnt_items/1
  def update
    if @dialogic_assmnt_item.update(dialogic_assmnt_item_params)
      render json: @dialogic_assmnt_item
    else
      render json: @dialogic_assmnt_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dialogic_assmnt_items/1
  def destroy
    @dialogic_assmnt_item.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dialogic_assmnt_item
    @dialogic_assmnt_item = DialogicAssmntItem.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dialogic_assmnt_item_params
    params.require(:dialogic_assmnt_item).permit(:key_topic_id, :assessment_label_id, :value_count_min, :value_count_max, :points)
  end
end
