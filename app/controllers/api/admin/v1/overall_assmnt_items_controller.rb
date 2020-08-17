# frozen_string_literal: true

# This controller have APIs for Overall Assmnt ...
class Api::Admin::V1::OverallAssmntItemsController < Api::Admin::V1::BaseController
  before_action :set_learning_object, only: %i[index create]
  before_action :set_overall_assmnt_item, only: %i[show update destroy]
  LEARN_OBJ_ID = 'learning object ID'

  # GET /overall_assmnt_items
  def index
    @overall_assmnt_items = @learning_object.overall_assmnt_items.order(:order)
    render json: serialize_rec(@overall_assmnt_items)
  end

  # GET /overall_assmnt_items/1
  def show
    render json: serialize_rec(@overall_assmnt_item)
  end

  # POST /overall_assmnt_items
  def create
    @overall_assmnt_item = @learning_object.overall_assmnt_items
                                           .new(overall_assmnt_item_params)
    @overall_assmnt_item.order = @overall_assmnt_item.assessment_label.order
    if @overall_assmnt_item.save
      render json: serialize_rec(@overall_assmnt_item), status: :created
    else
      render json: @overall_assmnt_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /overall_assmnt_items/1
  def update
    if @overall_assmnt_item.update(overall_assmnt_item_params)
      render json: serialize_rec(@overall_assmnt_item)
    else
      render json: @overall_assmnt_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /overall_assmnt_items/1
  def destroy
    @overall_assmnt_item.destroy
  end

  swagger_controller :overall_assmnt_items, 'OverallAssmntItem'
  swagger_api :index do
    summary 'List overall assessment items'
    notes 'Should be used to list assessment items'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
  end

  swagger_api :create do
    summary 'Creates a new overall assessment item'
    notes 'Should be used to create overall assessment item'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'learning_object_id', :integer, :required, LEARN_OBJ_ID
    param :form, 'overall_assmnt_item[assessment_label_id]', :integer,
          :required, 'Label Id'
    param :form, 'overall_assmnt_item[min_score]', :integer, :required,
          'min score'
    param :form, 'overall_assmnt_item[max_score]', :integer, :required,
          'max score'
    param :form, 'overall_assmnt_item[feedback]', :string, :required, 'name'

    response :unauthorized
  end

  swagger_api :update do
    summary 'Updates an overall assessment'
    notes 'Should be used to update an overall assessment'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'Overall Assessment ID'
    param :form, 'overall_assmnt_item[min_score]', :integer, :required,
          'min score'
    param :form, 'overall_assmnt_item[max_score]', :integer, :required,
          'max score'
    param :form, 'overall_assmnt_item[feedback]', :string, :required, 'name'

    response :unauthorized
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_overall_assmnt_item
    @overall_assmnt_item = OverallAssmntItem.find(params[:id])
  end

  def set_learning_object
    @learning_object = LearningObject.find(params[:learning_object_id])
  end

  # Only allow a trusted parameter "white list" through.
  def overall_assmnt_item_params
    params.require(:overall_assmnt_item).permit(:min_score, :max_score,
                                                :feedback, :assessment_label_id, :order)
  end

  def serializer
    OverallAssmntItemSerializer
  end
end
