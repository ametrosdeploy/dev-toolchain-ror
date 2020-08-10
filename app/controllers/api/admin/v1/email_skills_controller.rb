# frozen_string_literal: true

class Api::Admin::V1::EmailSkillsController < Api::Admin::V1::BaseController
  before_action :set_email_skill, only: %i[show update destroy]

  EMAIL_LO_ID = 'Email Learn Obj ID'
  GLOBAL_SKILL_ID = 'Gloal Skill ID'

  def index
      @email_skills = EmailSkill.all
      render json: serialize_rec(@email_skills)
  end
  
  def show
    render json: serialize_rec(@email_skill)
  end

  def create
    @email_skill = EmailSkill.new(email_skill_params)
    if @email_skill.save
      create_email_assessment_item_records

      render json: serialize_rec(@email_skill), status: :created
    else
      render json: @email_skill.errors, status: :unprocessable_entity
    end
  end

  def update
    if @email_skill.update(email_skill_params)
      render json: serialize_rec(@email_skill)
    else
      render json: @email_skill.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @email_skill.destroy
  end

  swagger_controller :email_skills, 'email_skill', resource_path:
    '/api/admin/v1/email skills'

  swagger_api :index do
    summary 'List email skills'
    notes 'Should be used to List all email skills for an email interaction learning object'
    param :header, :Authorization, :string, :required, 'Authorization'
  end

  swagger_api :create do
    summary 'Creates a new email skill'
    notes 'Should be used to create email skill'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'email_skill[email_learn_obj_id]', :integer, :required, EMAIL_LO_ID
    param :form, 'email_skill[global_skill_id]', :integer, :required, GLOBAL_SKILL_ID
    param :form, 'email_skill[name]', :integer, :optional, 'Skill name'
    param :form, 'email_skill[eval_explanation]', :text, :optional, 'Evaluation explanation (override default)'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show email skill'
    notes 'Should be used to Show email skill'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'email_skill ID'
  end

  swagger_api :update do
    summary 'Update email skill'
    notes 'Should be used to Update email skill'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'email_skill ID'
    param :form, 'email_skill[email_learn_obj_id]', :integer, :required, EMAIL_LO_ID
    param :form, 'email_skill[global_skill_id]', :integer, :required, GLOBAL_SKILL_ID
    param :form, 'email_skill[name]', :integer, :optional, 'Skill name'
    param :form, 'email_skill[eval_explanation]', :text, :optional, 'Evaluation explanation (override default)'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy an email skill'
    notes 'Should be used to destroy an email skill'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'Email Skill ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_email_skill 
    @email_skill = EmailSkill.find(params[:id])
  end  

  def set_email_learn_obj
    @email_lo = EmailLearnObj.find(params[:email_learn_obj_id])
    @lo = @email_lo.learning_object
  end

  def create_email_assessment_item_records 
    assessment_labels = @email_skill.email_learn_obj.learning_object.assessment_scheme.assessment_labels.order(order: :asc).pluck(:id)
    assessment_labels.each do |label| 
      EmailAssessmentItem.create(email_skill_id: @email_skill.id, assessment_label_id: label)
    end
  end 

  # Only allow a trusted parameter "white list" through.
  def email_skill_params
    params.require(:email_skill).permit(:email_learn_obj_id, :global_skill_id, :eval_explanation, :name)
  end

  def serializer
    EmailSkillSerializer
  end
end
  