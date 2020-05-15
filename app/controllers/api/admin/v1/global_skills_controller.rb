class Api::Admin::V1::GlobalSkillsController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_global_skill, only: [:show, :update, :destroy]

  def index
    @global_skills = GlobalSkill.all
    render json: serialize_rec(@global_skills)
  end

  def show
    render json: serialize_rec(@global_skill)
  end

  def create
    @global_skill = GlobalSkill.new(global_skill_params)
    if @global_skill.save
      render json: serialize_rec(@global_skill), status: :created
    else
      render json: @global_skill.errors, status: :unprocessable_entity
    end
  end

  def update
    if @global_skill.update(global_skill_params)
      render json: serialize_rec(@global_skill)
    else
      render json: @global_skill.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @global_skill.destroy
  end

  swagger_controller :global_skills, 'GlobalSkill', resource_path: '/api/admin/v1/global_skills'

  swagger_api :index do
    summary 'List global_skills'
    notes 'Should be used to List global_skills'
    param :header, :Authorization, :string, :required, 'Authorization'
  end

  swagger_api :create do
    summary 'Creates a new global_skill'
    notes 'Should be used to create global_skill'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'global_skill[name]', :string, :required, 'name'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show global_skill'
    notes 'Should be used to Show global_skill'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'global_skill Id'
  end

  swagger_api :update do
    summary 'Update global_skill'
    notes 'Should be used to Update global_skill'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'global_skill Id'
    param :form, 'global_skill[name]', :string, :required, 'name'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy a global_skill'
    notes 'Should be used to destroy a global_skill'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'global_skill Id'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_global_skill
    @global_skill = GlobalSkill.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def global_skill_params
    params.require(:global_skill).permit(:name)
  end

  def serializer
    GlobalSkillSerializer
  end
end
