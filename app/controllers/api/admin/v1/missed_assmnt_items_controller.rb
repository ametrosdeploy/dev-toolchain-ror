# frozen_string_literal: true

# This hanldes MissedAssmntItems related requests ...
class Api::Admin::V1::MissedAssmntItemsController < Api::Admin::V1::BaseController
  before_action :set_key_topic, only: %i[index create]
  before_action :set_missed_assmnt_item, only: %i[show update destroy]

  # GET /dialogic_assmnt_items
  def index
    @missed_assmnt_item = @key_topic.missed_assmnt_item
    render json: serialize_rec(@missed_assmnt_item)
  end

  def create
    @missed_assmnt_item = MissedAssmntItem.new(missed_assmnt_item_params)
    @missed_assmnt_item.key_topic = @key_topic
    if @missed_assmnt_item.save
      render json: serialize_rec(@missed_assmnt_item), status: :created
    else
      render json: @missed_assmnt_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @missed_assmnt_item.update(missed_assmnt_item_params)
      render json: serialize_rec(@missed_assmnt_item)
    else
      render json: @missed_assmnt_item.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: serialize_rec(@missed_assmnt_item)
  end

  def destroy
    @missed_assmnt_item.destroy
  end

  swagger_controller :missed_assmnt_items, 'Missed Assessment Item'

  swagger_api :index do
    summary 'Show the missed assessment for a KeyTopic'
    notes 'Should be used to show the missed assessment for a KeyTopic'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'key_topic_id', :integer, :required, 'Key Topic ID'
  end

  swagger_api :create do
    summary 'Creates Missed Assessment'
    notes 'Should be used to create a missed assessment'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'key_topic_id', :integer, :required, 'Key Topic ID'
    param :form, 'missed_assmnt_item[has_follow_up_question]', :boolean,
          :required, 'Have follow-up question?'
    param :form, 'missed_assmnt_item[follow_up_questions_attributes]
          [][iteration]', :integer, :optional, 'Follow up Iteration number'
    param :form, 'missed_assmnt_item[follow_up_questions_attributes][]
          [question]', :string, :optional, 'Follow up question'
    param :form, 'missed_assmnt_item[missed_responses_attributes]
          [][iteration]', :number, :required, 'Iteration number'
    param :form, 'missed_assmnt_item[missed_responses_attributes]
          [][variation]', :number, :required, 'Variation number'
    param :form, 'missed_assmnt_item[missed_responses_attributes]
          [][response]', :number, :required, 'Missed Response'
    response :unauthorized
  end

  swagger_api :update do
    summary 'Updates Missed Assessment'
    notes 'Should be used to update a missed assessment'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'key_topic_id', :integer, :required, 'Key Topic ID'
    param :path, 'id', :integer, :required, 'ID'
    param :form, 'missed_assmnt_item[has_follow_up_question]', :boolean,
          :required, 'Have follow-up question?'
    param :form, 'missed_assmnt_item[follow_up_questions_attributes][][id]',
          :integer, :optional, 'Follow up question ID'
    param :form, 'missed_assmnt_item[follow_up_questions_attributes]
          [][iteration]', :integer, :optional, 'Follow up Iteration number'
    param :form, 'missed_assmnt_item[follow_up_questions_attributes][]
          [question]', :string, :optional, 'Follow up question'
    param :form, 'missed_assmnt_item[follow_up_questions_attributes][]
          [_destroy]', :boolean, :optional, 'Set to true to delete'
    param :form, 'missed_assmnt_item[missed_responses_attributes]
          [][id]', :number, :optional, 'Response ID'
    param :form, 'missed_assmnt_item[missed_responses_attributes]
          [][iteration]', :number, :optional, 'Iteration number'
    param :form, 'missed_assmnt_item[missed_responses_attributes]
          [][variation]', :number, :optional, 'Variation number'
    param :form, 'missed_assmnt_item[missed_responses_attributes]
          [][response]', :string, :optional, 'Missed Response'
    param :form, 'missed_assmnt_item[missed_responses_attributes]
          [][_destroy]', :boolean, :optional, 'Set to true to delete'
    param :form, 'missed_assmnt_item[debriefs_attributes]
          [][id]', :number, :optional, 'Debrief ID'
    param :form, 'missed_assmnt_item[debriefs_attributes]
          [][content]', :string, :optional, 'Debrief Content'
    param :form, 'missed_assmnt_item[debriefs_attributes]
          [][_destroy]', :boolean, :optional, 'Set to true to delete'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show Missed Assessment'
    notes 'Should be used to show a Missed assessment'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_key_topic
    @key_topic = KeyTopic.find(params[:key_topic_id])
  end

  def set_missed_assmnt_item
    @missed_assmnt_item = MissedAssmntItem.includes(
      :follow_up_questions
    ).find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def missed_assmnt_item_params
    params.require(:missed_assmnt_item).permit(
      :key_topic_id, :has_follow_up_question,
      follow_up_questions_attributes: %i[id question iteration _destroy],
      missed_responses_attributes: %i[id response iteration
                                      variation _destroy],
      debriefs_attributes: %i[id content _destroy variation]
    )
  end

  def serializer
    MissedAssmntItemSerializer
  end
end
