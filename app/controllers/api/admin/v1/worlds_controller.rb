# frozen_string_literal: true

# Controller for worlds related requests
class Api::Admin::V1::WorldsController < Api::Admin::V1::BaseController
  include PaginateHsh
  before_action :set_world, only: %i[show update destroy world_orgs characters
                                     elm_lists assign_organization_role]
  SET_TRUE_TO_REMOVE = 'Set this to true to remove it'
  WORLD_ID = 'World Id'

  def index
    @list = Listing::Worlds.new(params: params)
    render json: @list.data
  end

  def show
    render json: serialize_rec(@world)
  end

  def create
    @world = World.new(world_params)
    if @world.save
      render json: serialize_rec(@world), status: :created
    else
      render json: @world.errors, status: :unprocessable_entity
    end
  end

  def update
    if @world.update(world_params)
      render json: serialize_rec(@world)
    else
      render json: @world.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @world.destroy
  end

  # Lists ELM's of a world
  def elm_lists
    learn_mods = @world.learn_mods.includes([:photo_attachment])
    learn_mods = learn_mods.paginate(page: params[:page],
                                     per_page: LearnMod::PER_PAGE)
    render json: LearnModTrimmedSerializer.new(learn_mods).serializable_hash
                                          .merge!(pagination_without_sort_hsh(
                                                    learn_mods, LearnMod
                                                  ))
  end

  # Used to auto complete learner organizations on ELM create
  def world_orgs
    world_orgs = @world.world_organizations.includes(organization: :industry)
    render json: WorldOrganizationTrimmedSerializer.new(world_orgs)
                                                   .serializable_hash
  end

  def characters
    org_ids = @world.world_organizations.pluck(:id)
    world_org_char = WorldOrgCharacter.includes([:world_role, :character,
                                                 world_organization:
                                                 :organization])
                                      .where(world_organization_id: org_ids)
    render json: WorldOrgCharacterTrimmedSerializer.new(world_org_char)
                                                   .serializable_hash
  end

  swagger_controller :worlds, 'World', resource_path: '/api/admin/v1/worlds'

  swagger_api :index do
    summary 'List worlds'
    notes 'Should be used to List worlds'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
    param :query, 'sort_column', :string, :optional, 'Options: "name",
          "created_at", "is_private", "learn_mods_count"'
    param :query, 'sort_order', :string, :optional, 'Options: "asc", "desc"'
  end

  swagger_api :create do
    summary 'Creates a new World'
    notes 'Should be used to create World'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'world[name]', :string, :required, 'name'
    param :form, 'world[description]', :string, :optional, 'description'
    param :form, 'world[customer_id]', :integer, :optional, 'customer_id'
    param :form, 'world[is_private]', :boolean, :required, 'is_private'
    param :form, 'world[world_organizations_attributes][][id]', :string,
          :optional, 'world_organizations id'
    param :form, 'world[world_organizations_attributes][][organization_id]',
          :string, :required, 'organization_id'
    param :form, 'world[world_organizations_attributes][][_destroy]', :boolean,
          :optional, SET_TRUE_TO_REMOVE
    param :form, 'world[world_organizations_attributes][][world_org_characters_attributes][][id]', :integer, :optional, 'world_org_characters id'
    param :form, 'world[world_organizations_attributes][][world_org_characters_attributes][][character_id]', :integer, :optional, 'character_id'
    param :form, 'world[world_organizations_attributes][][world_org_characters_attributes][][world_role_id]', :string, :required, 'world_role_id'
    param :form, 'world[world_organizations_attributes][][world_org_characters_attributes][][_destroy]', :boolean, :optional, 'Set this to true to remove'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show world'
    notes 'Should be used to Show world'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, WORLD_ID
  end

  swagger_api :update do
    summary 'Update World'
    notes 'Should be used to Update World'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, WORLD_ID
    param :form, 'world[name]', :string, :required, 'name'
    param :form, 'world[description]', :string, :optional, 'description'
    param :form, 'world[customer_id]', :integer, :optional, 'customer_id'
    param :form, 'world[is_private]', :boolean, :required, 'is_private'
    param :form, 'world[world_organizations_attributes][][id]', :string,
          :optional, 'world_organizations id'
    param :form, 'world[world_organizations_attributes][][organization_id]',
          :string, :required, 'organization_id'
    param :form, 'world[world_organizations_attributes][][_destroy]', :boolean,
          :optional, SET_TRUE_TO_REMOVE
    param :form, 'world[world_organizations_attributes][][world_org_characters_attributes][][id]', :integer, :optional, 'world_org_characters id'
    param :form, 'world[world_organizations_attributes][][world_org_characters_attributes][][character_id]', :integer, :optional, 'character_id'
    param :form, 'world[world_organizations_attributes][][world_org_characters_attributes][][world_role_id]', :string, :required, 'world_role_id'
    param :form, 'world[world_organizations_attributes][][world_org_characters_attributes][][_destroy]', :boolean, :optional, 'Set this to true to remove'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy a World'
    notes 'Should be used to destroy a World'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, WORLD_ID
  end

  swagger_api :elm_lists do
    summary 'List ELM\'s of a world'
    notes 'Should be used to List ELM\'s of a world'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, WORLD_ID
    param :query, 'page', :string, :optional, 'Page Number'
  end

  swagger_api :world_orgs do
    summary 'World Organizations list'
    notes 'Should be used to auto complete learner organizations on ELM create'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, WORLD_ID
  end

  swagger_api :characters do
    summary 'World Organizations characters'
    notes 'Should be used to list characters of a world'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, WORLD_ID
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_world
    @world = World.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def world_params
    params.require(:world).permit(:name, :description, :customer_id,
                                  :is_private,
                                  world_organizations_attributes: [
                                    :id, :organization_id, :_destroy,
                                    world_org_characters_attributes: %i[
                                      id world_role_id character_id _destroy
                                    ]
                                  ])
  end

  def serializer
    WorldSerializer
  end
end
