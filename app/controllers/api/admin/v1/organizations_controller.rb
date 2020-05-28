# frozen_string_literal: true

# Controller for organization related requests
class Api::Admin::V1::OrganizationsController < Api::Admin::V1::BaseController
  include PaginateHsh
  before_action :set_organization, only: %i[show update destroy
                                            assign_role remove_photo]
  before_action :orgs, only: [:assign_org_list]
  ORGANIZATION_ID = 'organization Id'

  def index
    @list = Listing::Organizations.new({ params: params })
    render json: @list.data
  end

  def show
    render json: serialize_rec(@organization)
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      render json: serialize_rec(@organization), status: :created
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  def update
    if @organization.update(organization_params)
      render json: serialize_rec(@organization)
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @organization.destroy
  end

  # Removed Organization Photo
  def remove_photo
    @organization.photo.try(:purge)
  end

  # Auto complete Assign organizations to characters
  def assign_org_list
    @orgs = @orgs.search(params[:search]) if params[:search].present?
    @orgs = @orgs.paginate(page: params[:page],
                           per_page: Organization::PER_PAGE)
    pagination_resp = pagination_without_sort_hsh(@orgs, Organization)
    render json: serialize_rec(@orgs).merge!(pagination_resp)
  end

  swagger_controller :organizations, 'organization', resource_path:
    '/api/admin/v1/organizations'

  swagger_api :index do
    summary 'List organizations'
    notes 'Should be used to List organizations'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
    param :query, 'sort_column', :string, :optional, 'Options:
    "organizations.name", "created_at", "industries.name", "characters_count"'
    param :query, 'sort_order', :string, :optional, 'Options: "asc", "desc"'
  end

  swagger_api :create do
    summary 'Creates a new organization'
    notes 'Should be used to create organization'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'organization[name]', :string, :required, 'name'
    param :form, 'organization[description]', :string, :optional, 'description'
    param :form, 'organization[photo]', :string, :optional, 'photo'
    param :form, 'organization[industry_attributes][name]', :string, :optional,
          'industry name'
    param :form, 'organization[organization_characters_attributes][][id]',
          :integer, :optional, 'organization_characters_id'
    param :form, 'organization[organization_characters_attributes][]
          [character_id]', :integer, :optional, 'character_id'
    param :form, 'organization[organization_characters_attributes][]
          [world_role_id]', :string, :required, 'world_role_id'
    param :form, 'organization[organization_characters_attributes][][_destroy]',
          :boolean, :optional, 'set to true to delete record'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show organization'
    notes 'Should be used to Show organization'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, ORGANIZATION_ID
  end

  swagger_api :update do
    summary 'Update organization'
    notes 'Should be used to Update organization'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, ORGANIZATION_ID
    param :form, 'organization[name]', :string, :required, 'name'
    param :form, 'organization[description]', :string, :optional, 'description'
    param :form, 'organization[photo]', :string, :optional, 'photo'
    param :form, 'organization[industry_attributes][name]', :string, :optional,
          'industry name'
    param :form, 'organization[organization_characters_attributes][][id]',
          :integer, :optional, 'organization_characters_id'
    param :form, 'organization[organization_characters_attributes][]
          [character_id]', :integer, :optional, 'character_id'
    param :form, 'organization[organization_characters_attributes][]
          [world_role_id]', :string, :required, 'world_role_id'
    param :form, 'organization[organization_characters_attributes][][_destroy]',
          :boolean, :optional, 'set to true to delete record'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy a organization'
    notes 'Should be used to destroy a organization'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, ORGANIZATION_ID
  end

  swagger_api :remove_photo do
    summary 'Destroys photo of organization'
    notes 'Should be used to destroy photo of organization'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, ORGANIZATION_ID
  end

  swagger_api :assign_org_list do
    summary 'Auto complete Assign organizations to characters'
    notes 'Should be used to Auto complete Assign organizations to characters'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
    param :query, 'character_id', :integer, :required, 'Character ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def organization_params
    params.require(:organization)
          .permit(:name, :description, :photo,
                  industry_attributes: [:name],
                  organization_characters_attributes:
                  %i[character_id world_role_id _destroy])
  end

  def serializer
    OrganizationWithCharacterSerializer
  end

  def orgs
    @orgs = Organization.joins(:industry)
                        .with_attached_photo
                        .includes(:organization_characters,
                                  characters: [:photo_attachment])
    select_characters = Character.find(params[:character_id])
                                 .organization_characters
                                 .pluck(:organization_id)
    @orgs = @orgs.where.not(id: select_characters)
  end
end
