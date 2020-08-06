# frozen_string_literal: true

# Here goes the code for Admin email assessments setup ...
class Api::Admin::V1::EmailAssessmentItemsController < Api::Admin::V1::BaseController
  before_action :set_email_skill, only: %i[index create]
  before_action :set_email_assessment_item, only: %i[show update destroy]

  # GET /email_assessments
  def index
    @email_assessment_items = @email_skill.email_assessment_items
    render json: serialize_rec(@email_assessment_items)
  end

  # GET /email_assessments/1
  def show
    render json: serialize_rec(@email_assessment_item)
  end

  # POST /email_assessments
  def create
    @email_assessment_item = @email_skill.email_assessment_items
                                      .new(email_assessment_item_params)
    if @email_assessment_item.save && create_char_response_records
      render json: serialize_rec(@email_assessment_item), status: :created
    else
      render json: @email_assessment_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /email_assessments/1
  def update
    if @email_assessment_item.update(email_assessment_item_params)
      render json: serialize_rec(@email_assessment_item)
    else
      render json: @email_assessment_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /email_assessments/1
  def destroy
    @email_assessment_item.destroy
  end

  swagger_controller :email_assessment_items, 'Email Assessment Items'

  swagger_api :index do
    summary 'List all email assessment items for an Email Skill'
    notes 'Should be used to List all email assessment items for an email skill'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'email_skill_id', :integer, :required, 'Email Skill ID'
  end

  swagger_api :create do
    summary 'Creates an email assessment item'
    notes 'Should be used to create an email assessment item'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'email_skill_id', :integer, :required, 'Email Skill ID'
    param :form, 'email_assessment_item[assessment_label_id]', :string, :required, 'Name'
    param :form, 'email_assessment_item[debriefs_attributes][][id]',
          :integer, :optional, 'Debrief attributes ID'
        param :form, 'email_assessment_item[debriefs_attributes][][content]',
            :text, :optional, 'Debrief content'
        param :form, 'email_assessment_item[debriefs_attributes][][_destroy]',
            :boolean, :optional, 'Debrief Set to true to delete'

    response :unauthorized
  end

  swagger_api :update do
    summary 'Updates an email assessment item'
    notes 'Should be used to update an email response'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'ID'
    param :path, 'email_skill_id', :integer, :required, 'Email Skill ID'
    param :form, 'email_assessment_item[assessment_label_id]', :string, :required, 'Name'
    param :form, 'email_assessment_item[debriefs_attributes][][id]',
          :integer, :optional, 'Debrief attributes ID'
        param :form, 'email_assessment_item[debriefs_attributes][][content]',
            :text, :optional, 'Debrief content'
        param :form, 'email_assessment_item[debriefs_attributes][][_destroy]',
            :boolean, :optional, 'Debrief Set to true to delete'

    response :unauthorized
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_email_learn_obj
    @email_learn_obj = EmailLearnObj.find(params[:email_learn_obj_id])
  end

  def set_email_assessment_item
    @email_assessment_item = EmailAssessmentItem.find(params[:id])
  end

  def create_char_response_records
    iteration_level = @email_learn_obj.iteration_level || 1
    (1..iteration_level).each do |iteration|
      @email_assessment_item.char_response_variations.create(
        iteration: iteration, variation: 1
      )
    end
  end

  # Only allow a trusted parameter "white list" through.
  def email_assessment_item_params
    params.require(:email_response).permit(
      :email_skill_id, :assessment_label_id,
      debriefs_attributes: %i[id content _destroy]
    )
  end

  def serializer
    EmailAsessmentItemSerializer
  end
end
