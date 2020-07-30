# frozen_string_literal: true

# Controller for world organization related requests
class Api::Admin::V1::WorldOrganizationsController <
                                                  Api::Admin::V1::BaseController
  before_action :set_world
  before_action :set_world_organizations, only: %i[show update destroy]

  WORLD_ID = 'world Id'
  WORLD_ORGANIZATIONS_ID = 'world_organizations Id'

  def index
    @world_organizations = @world.world_organizations
                                 .includes(:organization, :world_org_characters,
                                           :characters)
    render json: serialize_rec(@world_organizations)
  end

  def show
    render json: serialize_rec(@world_organization)
  end

  def create
    @world_organization = @world.world_organizations
                                .build(world_organization_params)
    if @world_organization.save
      render json: serialize_rec(@world_organization), status: :created
    else
      render json: @world_organization.errors, status: :unprocessable_entity
    end
  end

  def update
    if @world_organization.update(world_organization_params)
      render json: serialize_rec(@world_organization)
    else
      render json: @world_organization.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @world_organization.destroy
  end

  swagger_controller :world_organizations, 'WorldOrganization', resource_path:
    '/api/admin/v1/worlds/:world_id/world_organizations'

  swagger_api :index do
    summary 'List world_organizations'
    notes 'Should be used to List world_organizations'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'world_id', :string, :required, WORLD_ID
  end

  swagger_api :create do
    summary 'Creates a new world_organizations'
    notes 'Should be used to create world_organizations'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'world_id', :string, :required, WORLD_ID
    param :form, 'world_organization[organization_id]', :string, :required,
          'organization_id'
    param :form, 'world_organization[world_org_characters_attributes][][id]',
          :integer, :optional, 'world_org_characters id'
    param :form, 'world_organization[world_org_characters_attributes][][character_id]', :integer, :optional, 'character_id'
    param :form, 'world_organization[world_org_characters_attributes][][world_role_id]', :string, :required, 'world_role_id'
    param :form, 'world_organization[world_org_characters_attributes][]
          [_destroy]', :boolean, :optional, 'Set this to true to remove'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show world_organizations'
    notes 'Should be used to Show world_organizations'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'world_id', :string, :required, WORLD_ID
    param :path, 'id', :string, :required, WORLD_ORGANIZATIONS_ID
  end

  swagger_api :update do
    summary 'Update world_organizations'
    notes 'Should be used to Update world_organizations'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'world_id', :string, :required, WORLD_ID
    param :path, 'id', :string, :required, WORLD_ORGANIZATIONS_ID
    param :form, 'world_organization[organization_id]', :string, :required,
          'organization_id'
    param :form, 'world_organization[world_org_characters_attributes][][id]',
          :integer, :optional, 'world_org_characters id'
    param :form, 'world_organization[world_org_characters_attributes][][character_id]', :integer, :optional, 'character_id'
    param :form, 'world_organization[world_org_characters_attributes][][world_role_id]', :string, :required, 'world_role_id'
    param :form, 'world_organization[world_org_characters_attributes][]
          [_destroy]', :boolean, :optional, 'Set this to true to remove'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy a world_organizations'
    notes 'Should be used to destroy a world_organizations'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'world_id', :string, :required, WORLD_ID
    param :path, 'id', :string, :required, WORLD_ORGANIZATIONS_ID
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_world
    @world = World.find(params[:world_id])
  end

  def set_world_organizations
    @world_organization = @world.world_organizations.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def world_organization_params
    params.require(:world_organization).permit(:organization_id,
                                               world_org_characters_attributes:
                                               %i[id world_role_id character_id
                                                  _destroy])
  end

  def serializer
    WorldOrganizationCustomSerializer
  end
end
