# frozen_string_literal: true

# Controller for ELM creation
class Api::Admin::V1::LearnModsController < Api::Admin::V1::BaseController
  before_action :set_learn_mod, only: %i[show update destroy reorder_cards
                                         update_status remove_photo]
  ELM_ID = 'ELM Id'

  def index
    @list = Listing::LearnMods.new(params: params)
    render json: @list.data
  end

  def show
    render json: serialize_rec(@learn_mod)
  end

  def create
    @learn_mod = LearnMod.new(learn_mod_params)
    ibm_req = asst_creation_request
    if ibm_req.valid? && @learn_mod.save
      save_asst_service_credential(ibm_req)
      render json: serialize_rec(@learn_mod), status: :created
    else
      err = ibm_req.valid? ? @learn_mod.errors : ibm_req.message
      render json: err, status: :unprocessable_entity
    end
  end

  def update
    if @learn_mod.update(learn_mod_params)
      render json: serialize_rec(@learn_mod)
    else
      render json: @learn_mod.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @learn_mod.destroy
  end

  # Removed Character Photo
  def remove_photo
    @learn_mod.photo.try(:purge)
  end

  # Reorder cards
  def reorder_cards
    if @learn_mod.update(learning_obj_params)
      render json: {}, status: 200
    else
      render json: @learn_mod.errors, status: :unprocessable_entity
    end
  end

  def update_status
    if @learn_mod.can_be_published? && @learn_mod.toggle_publish
      render json: {}, status: 200
    else
      render json: @learn_mod.errors, status: :unprocessable_entity
    end
  end

  swagger_controller :learn_mods, 'LearnMod', resource_path:
    '/api/admin/v1/learn_mods'

  swagger_api :index do
    summary 'List ELM'
    notes 'Should be used to List ELM'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
    param :query, 'sort_column', :string, :optional, 'Options: "learn_mods.name"
    , "created_at", "learning_objects_count", "time_to_complete", "worlds.name"'
    param :query, 'sort_order', :string, :optional, 'Options: "asc", "desc"'
  end

  swagger_api :create do
    summary 'Creates a new ELM'
    notes 'Should be used to create ELM'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'learn_mod[name]', :string, :required, 'name'
    param :form, 'learn_mod[time_to_complete]', :integer, :required,
          'time_to_complete'
    param :form, 'learn_mod[abstract]', :string, :optional, 'abstract'
    param :form, 'learn_mod[world_id]', :integer, :required, 'world_id'
    param :form, 'learn_mod[description]', :string, :optional, 'description'
    param :form, 'learn_mod[lead_designer_id]', :integer, :optional,
          'lead_designer_id'
    param :form, 'learn_mod[sme_id]', :integer, :optional, 'sme_id'
    param :form, 'learn_mod[learning_objectives]', :string, :optional,
          'learning_objectives(Comma seperated)'
    param :form, 'learn_mod[notes]', :string, :optional, 'notes'
    param :form, 'learn_mod[intro_video_id]', :integer, :optional,
          'intro_video_id'
    param :form, 'learn_mod[photo]', :string, :optional, 'photo'
    param :form, 'learn_mod[learn_mod_organizations_attributes][][id]',
          :integer, :optional, 'learn_mod_organizations ID'
    param :form, 'learn_mod[learn_mod_organizations_attributes][]
      [is_learner_organization]', :boolean, :optional, 'is_learner_organization'
    param :form, 'learn_mod[learn_mod_organizations_attributes][]
      [world_role_id]', :boolean, :optional, 'world_role_id'
    param :form, 'learn_mod[learn_mod_organizations_attributes][]
      [world_organization_id]', :integer, :optional, 'world_organization_id'
    param :form, 'learn_mod[global_skill_ids][]', :integer, :optional,
          'global_skill_ids'
    param :form, 'learn_mod[global_resource_ids][]', :integer, :optional,
          'global_resource_ids'

    response :unauthorized
  end

  swagger_api :show do
    summary 'Show ELM'
    notes 'Should be used to Show ELM'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, ELM_ID
  end

  swagger_api :update do
    summary 'Update ELM'
    notes 'Should be used to Update ELM'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, ELM_ID
    param :form, 'learn_mod[name]', :string, :required, 'name'
    param :form, 'learn_mod[time_to_complete]', :integer, :required,
          'time_to_complete'
    param :form, 'learn_mod[abstract]', :string, :optional, 'abstract'
    param :form, 'learn_mod[world_id]', :integer, :required, 'world_id'
    param :form, 'learn_mod[description]', :string, :optional, 'description'
    param :form, 'learn_mod[lead_designer_id]', :integer, :optional,
          'lead_designer_id'
    param :form, 'learn_mod[sme_id]', :integer, :optional, 'sme_id'
    param :form, 'learn_mod[learning_objectives]', :string, :optional,
          'learning_objectives(Comma seperated)'
    param :form, 'learn_mod[notes]', :string, :optional, 'notes'
    param :form, 'learn_mod[intro_video_id]', :integer, :optional,
          'intro_video_id'
    param :form, 'learn_mod[photo]', :string, :optional, 'photo'
    param :form, 'learn_mod[learn_mod_organizations_attributes][][id]',
          :integer, :optional, 'learn_mod_organizations ID'
    param :form, 'learn_mod[learn_mod_organizations_attributes][]
      [is_learner_organization]', :boolean, :optional, 'is_learner_organization'
    param :form, 'learn_mod[learn_mod_organizations_attributes][]
      [world_role_id]', :boolean, :optional, 'world_role_id'
    param :form, 'learn_mod[learn_mod_organizations_attributes][]
      [world_organization_id]', :integer, :optional, 'world_organization_id'
    param :form, 'learn_mod[global_skill_ids][]', :integer, :optional,
          'global_skill_ids'
    param :form, 'learn_mod[global_resource_ids][]', :integer, :optional,
          'global_resource_ids'

    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy an ELM'
    notes 'Should be used to destroy an ELM'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, ELM_ID
  end

  swagger_api :remove_photo do
    summary 'Destroys photo of ELM'
    notes 'Should be used to destroy photo of ELM'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, ELM_ID
  end

  swagger_api :update_status do
    summary 'Publish ELM'
    notes 'Should be used to Publish ELM'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, ELM_ID
  end

  swagger_api :reorder_cards do
    summary 'Reorder Cards'
    notes 'Should be used to Reorder Cards'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, ELM_ID
    param :form, 'learn_mod[learning_objects_attributes][][id]', :string,
          :required, 'card ID'
    param :form, 'learn_mod[learning_objects_attributes][][card_order]',
          :integer, :required, 'card order ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_learn_mod
    @learn_mod = LearnMod.find(params[:id])
  end

  def asst_creation_request
    ibm_service = IbmService.new
    ibm_service.generate_instance(@learn_mod.name)
    ibm_service
  end

  def save_asst_service_credential(ibm_service)
    guid = ibm_service.response
    AsstServiceInstance.create(guid: guid, learn_mod_id: @learn_mod.id)
  end

  # Only allow a trusted parameter "white list" through.
  def learn_mod_params
    params.require(:learn_mod).permit(:name, :time_to_complete, :abstract,
                                      :world_id, :description, :sme_id,
                                      :lead_designer_id, :learning_objectives,
                                      :notes, :intro_video_id, :photo,
                                      learn_mod_organizations_attributes: %i[
                                        is_learner_organization world_role_id
                                        world_organization_id
                                      ], global_skill_ids: [],
                                      global_resource_ids: [])
  end

  def learning_obj_params
    params.require(:learn_mod).permit(learning_objects_attributes:
                                      %i[id card_order])
  end

  def serializer
    LearnModSerializer
  end
end
