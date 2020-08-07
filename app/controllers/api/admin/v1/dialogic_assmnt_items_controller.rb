# frozen_string_literal: true

# This hanldes all DialogicAssmntItems related requests ...
class Api::Admin::V1::DialogicAssmntItemsController < Api::Admin::V1::BaseController
  before_action :set_key_topic, only: %i[index create]
  before_action :set_dialogic_assmnt_item, only: %i[show update destroy]

  # GET /dialogic_assmnt_items
  def index
    @dialogic_assmnt_items = @key_topic.dialogic_assmnt_items
    render json: serialize_rec(@dialogic_assmnt_items)
  end

  # GET /dialogic_assmnt_items/1
  def show
    render json: serialize_rec(@dialogic_assmnt_item)
  end

  # POST /dialogic_assmnt_items
  def create
    @dialogic_assmnt_item = @key_topic.dialogic_assmnt_items.new(
      dialogic_assmnt_item_params
    )
    if @dialogic_assmnt_item.save
      render json: serialize_rec(@dialogic_assmnt_item), status: :created
    else
      render json: @dialogic_assmnt_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dialogic_assmnt_items/1
  def update
    if @dialogic_assmnt_item.update(dialogic_assmnt_item_params)
      render json: serialize_rec(@dialogic_assmnt_item)
    else
      render json: @dialogic_assmnt_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dialogic_assmnt_items/1
  def destroy
    @dialogic_assmnt_item.destroy
  end

  swagger_controller :dialogic_assmnt_items, 'Dialogic Assessment Item'

  swagger_api :index do
    summary 'List all assessments for a KeyTopic'
    notes 'Should be used to list all assessments for a KeyTopic'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'key_topic_id', :integer, :required, 'Key Topic ID'
  end

  swagger_api :create do
    summary 'Creates Dialogic Assessment'
    notes 'Should be used to create a dialogic assessment'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'key_topic_id', :integer, :required, 'Key Topic ID'
    param :form, 'dialogic_assmnt_item[assessment_label_id]',
          :integer, :required
    param :form, 'dialogic_assmnt_item[value_count_min]', :integer, :required,
          'Entity Value - Minimum'
    param :form, 'dialogic_assmnt_item[value_count_max]', :integer, :required,
          'Entity Value - Maximum'
    param :form, 'dialogic_assmnt_item[points]', :number, :required, 'Points'
    param :form, 'dialogic_assmnt_item[follow_up_points]', :number,
          :required, 'follow_up Points'
    param :form, 'dialogic_assmnt_item[have_follow_up_question]', :boolean,
          :required, 'Have follow-up question?'
    param :form, 'dialogic_assmnt_item[follow_up_questions_attributes][]
          [id]', :integer, :optional, 'Follow up question ID'
    param :form, 'dialogic_assmnt_item[follow_up_questions_attributes]
          [][iteration]', :integer, :optional, 'Follow up Iteration number'
    param :form, 'dialogic_assmnt_item[follow_up_questions_attributes]
          [][question]', :string, :optional, 'Follow up question'
    param :form, 'dialogic_assmnt_item[follow_up_questions_attributes][]
          [_destroy]', :boolean, :optional, 'Set to true to delete'
    param :form, 'dialogic_assmnt_item[required_key_topic_values_attributes]
          [][key_topic_value_id]', :number, :optional, 'Key Topic Value ID'
    param :form, 'dialogic_assmnt_item[dialogic_responses_attributes]
          [][iteration]', :number, :required, 'Iteration number'
    param :form, 'dialogic_assmnt_item[dialogic_responses_attributes]
          [][variation]', :number, :required, 'Variation number'
    param :form, 'dialogic_assmnt_item[dialogic_responses_attributes]
          [][response]', :string, :required, 'Dialogic Response'
    response :unauthorized
  end

  swagger_api :update do
    summary 'Update Dialogic Assessment'
    notes 'Should be used to update dialogic assessment'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
    param :form, 'dialogic_assmnt_item[assessment_label_id]',
          :integer, :required
    param :form, 'dialogic_assmnt_item[value_count_min]', :integer, :required,
          'Entity Value - Minimum'
    param :form, 'dialogic_assmnt_item[value_count_max]', :integer, :required,
          'Entity Value - Maximum'
    param :form, 'dialogic_assmnt_item[points]', :number, :required, 'Points'
    param :form, 'dialogic_assmnt_item[follow_up_points]', :number,
          :required, 'follow_up Points'
    param :form, 'dialogic_assmnt_item[have_follow_up_question]', :boolean,
          :required, 'Have follow-up question?'
    param :form, 'dialogic_assmnt_item[follow_up_questions_attributes]
          [][id]', :integer, :optional, 'Follow up question ID'
    param :form, 'dialogic_assmnt_item[follow_up_questions_attributes]
          [][iteration]', :integer, :optional, 'Follow up Iteration number'
    param :form, 'dialogic_assmnt_item[follow_up_questions_attributes]
          [][question]', :string, :optional, 'Follow up question'
    param :form, 'dialogic_assmnt_item[required_key_topic_values_attributes]
          [][id]', :number, :optional, 'Required Value ID'
    param :form, 'dialogic_assmnt_item[required_key_topic_values_attributes]
          [][key_topic_value_id]', :number, :optional, 'Key Topic Value ID'
    param :form, 'dialogic_assmnt_item[required_key_topic_values_attributes]
          [][_destroy]', :number, :optional, 'Set to true to delete'
    param :form, 'dialogic_assmnt_item[dialogic_responses_attributes][][id]',
          :number, :optional, 'Dialogic Response ID'
    param :form, 'dialogic_assmnt_item[dialogic_responses_attributes]
          [][iteration]', :number, :optional, 'Iteration number'
    param :form, 'dialogic_assmnt_item[dialogic_responses_attributes]
          [][variation]', :number, :optional, 'Variation number'
    param :form, 'dialogic_assmnt_item[dialogic_responses_attributes]
          [][response]', :string, :optional, 'Dialogic Response'
    param :form, 'dialogic_assmnt_item[dialogic_responses_attributes]
          [][_destroy]', :number, :optional, 'Set to true to delete'
    param :form, 'dialogic_assmnt_item[debriefs_attributes][][id]',
          :number, :optional, 'Debrief ID'
    param :form, 'dialogic_assmnt_item[debriefs_attributes][][content]',
          :text, :optional, 'Debrief Content'
    param :form, 'dialogic_assmnt_item[debriefs_attributes][][_destroy]',
          :boolean, :optional, 'Set to true to delete'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show Dialogic Assessment'
    notes 'Should be used to show a dialogic assessment'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_key_topic
    @key_topic = KeyTopic.find(params[:key_topic_id])
  end

  def set_dialogic_assmnt_item
    @dialogic_assmnt_item = DialogicAssmntItem.includes(
      :follow_up_questions, :required_key_topic_values
    ).find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dialogic_assmnt_item_params
    params.require(:dialogic_assmnt_item).permit(
      :key_topic_id, :assessment_label_id, :value_count_min,
      :value_count_max, :points, :follow_up_points, :have_follow_up_question,
      follow_up_questions_attributes: %i[id question iteration _destroy],
      required_key_topic_values_attributes: %i[id key_topic_value_id
                                               _destroy],
      dialogic_responses_attributes: %i[id response iteration variation
                                        _destroy],
      debriefs_attributes: %i[id content _destroy]
    )
  end

  def serializer
    DialogicAssmntItemSerializer
  end
end
