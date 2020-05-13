class Api::Admin::V1::LearnModsController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_learn_mod, only: [:show, :update, :destroy]

  def index
    @lear_mods = LearnMod.includes(:world, :lead_designer, :sme, :intro_video,
                :learn_mod_skills, :global_skills, :learn_mod_organizations,
                :learn_mod_intro_docs, :global_resources)
    @lear_mods = @lear_mods.search(params[:search]) if params[:search].present?
    @lear_mods = @lear_mods.order("#{sort_column} #{sort_order}")
    @lear_mods = @lear_mods.paginate(page: params[:page],
                                                   per_page: LearnMod::PER_PAGE)
    render json: serialize_rec(@lear_mods).merge!(
                                           pagination_hsh(@lear_mods, LearnMod))
  end

  def show
    render json: serialize_rec(@lear_mod)
  end

  def create
    @lear_mod = LearnMod.new(learn_mod_params)
    if @lear_mod.save
      render json: serialize_rec(@lear_mod), status: :created
    else
      render json: @lear_mod.errors, status: :unprocessable_entity
    end
  end

  def update
    if @lear_mod.update(learn_mod_params)
      render json: serialize_rec(@lear_mod)
    else
      render json: @lear_mod.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @lear_mod.destroy
  end

  swagger_controller :learn_mods, 'LearnMod', resource_path: '/api/admin/v1/learn_mods'

  swagger_api :index do
    summary 'List ELM'
    notes 'Should be used to List ELM'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
    param :query, 'sort_column', :string, :optional, 'Options: "name",
    "created_at", "learning_objects_count", "time_to_complete"'
    param :query, 'sort_order', :string, :optional, 'Options: "asc", "desc"'
  end

  swagger_api :create do
    summary 'Creates a new ELM'
    notes 'Should be used to create ELM'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'learn_mod[name]', :string, :required, 'name'
    param :form, 'learn_mod[time_to_complete]', :integer, :required, 'time_to_complete'
    param :form, 'learn_mod[abstract]', :boolean, :optional, 'abstract'
    param :form, 'learn_mod[world_id]', :integer, :required, 'world_id'
    param :form, 'learn_mod[description]', :string, :optional, 'description'
    param :form, 'learn_mod[lead_designer_id]', :integer, :optional, 'lead_designer_id'
    param :form, 'learn_mod[sme_id]', :integer, :optional, 'sme_id'
    param :form, 'learn_mod[learning_objectives]', :string, :optional, 'learning_objectives(Comma seperated)'
    param :form, 'learn_mod[notes]', :string, :optional, 'notes'
    param :form, 'learn_mod[intro_video_id]', :optional, :required, 'intro_video_id'
    param :form, 'learn_mod[photo]', :string, :optional, 'photo'
    param :form, 'learn_mod[learn_mod_organizations_attributes][][id]', 
    :integer, :optional, 'learn_mod_organizations ID'
    param :form, 'learn_mod[learn_mod_organizations_attributes][][is_learner_organization]', 
    :boolean, :optional, 'is_learner_organization'
    param :form, 'learn_mod[learn_mod_organizations_attributes][][world_organization_id]', 
    :integer, :optional, 'world_organization_id'
    param :form, 'learn_mod[learn_mod_organizations_attributes][][_destroy]', 
    :boolean, :optional, 'Set this to true to remove it.'
    param :form, 'learn_mod[global_skill_ids][]', :integer, :optional, 'global_skill_ids'
    param :form, 'learn_mod[global_resource_ids][]', :integer, :optional, 'global_resource_ids'

    response :unauthorized
  end

  swagger_api :show do
    summary 'Show ELM'
    notes 'Should be used to Show ELM'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'ELM Id'
  end

  swagger_api :update do
    summary 'Update ELM'
    notes 'Should be used to Update ELM'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'ELM Id'
    param :form, 'learn_mod[name]', :string, :required, 'name'
    param :form, 'learn_mod[time_to_complete]', :integer, :required, 'time_to_complete'
    param :form, 'learn_mod[abstract]', :boolean, :optional, 'abstract'
    param :form, 'learn_mod[world_id]', :integer, :required, 'world_id'
    param :form, 'learn_mod[description]', :string, :optional, 'description'
    param :form, 'learn_mod[lead_designer_id]', :integer, :optional, 'lead_designer_id'
    param :form, 'learn_mod[sme_id]', :integer, :optional, 'sme_id'
    param :form, 'learn_mod[learning_objectives]', :string, :optional, 'learning_objectives(Comma seperated)'
    param :form, 'learn_mod[notes]', :string, :optional, 'notes'
    param :form, 'learn_mod[intro_video_id]', :optional, :required, 'intro_video_id'
    param :form, 'learn_mod[photo]', :string, :optional, 'photo'
    param :form, 'learn_mod[learn_mod_organizations_attributes][][id]', 
    :integer, :optional, 'learn_mod_organizations ID'
    param :form, 'learn_mod[learn_mod_organizations_attributes][][is_learner_organization]', 
    :boolean, :optional, 'is_learner_organization'
    param :form, 'learn_mod[learn_mod_organizations_attributes][][world_organization_id]', 
    :integer, :optional, 'world_organization_id'
    param :form, 'learn_mod[learn_mod_organizations_attributes][][_destroy]', 
    :boolean, :optional, 'Set this to true to remove it.'
    param :form, 'learn_mod[global_skill_ids][]', :integer, :optional, 'global_skill_ids'
    param :form, 'learn_mod[global_resource_ids][]', :integer, :optional, 'global_resource_ids'

    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy an ELM'
    notes 'Should be used to destroy an ELM'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'ELM Id'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_learn_mod
    @lear_mod = LearnMod.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def learn_mod_params
    params.require(:learn_mod).permit(:name, :time_to_complete, :abstract,
      :world_id, :description, :lead_designer_id, :sme_id, :learning_objectives,
      :notes, :intro_video_id, :photo, learn_mod_organizations_attributes: [
      :is_learner_organization, :world_organization_id], global_skill_ids: [],
      global_resource_ids: [])
  end

  def serializer
    LearnModSerializer
  end

  # Set default sort Column
  def sort_column
    valid_sort && params[:sort_column] || 'id'
  end

  # Validate sort key & set default sort type
  def sort_order
    sort_type = params[:sort_order]
    sort_type.present? && %w[asc desc].include?(sort_type) && sort_type || 'desc'
  end

  # Verify available sort options
  def valid_sort
    params[:sort_column].present? && ['name', 'created_at', 'time_to_complete',
      'learning_objects_count'].include?(params[:sort_column])
  end

end
