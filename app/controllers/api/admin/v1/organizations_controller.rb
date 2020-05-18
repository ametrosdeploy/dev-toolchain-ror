# frozen_string_literal: true

class Api::Admin::V1::OrganizationsController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_organization, only: %i[show update destroy
                                            assign_role remove_photo]

  ORGANIZATION_ID = 'organization Id'

  def index
    @organizations = Organization.joins(:industry).with_attached_photo.includes(
      organization_characters: [:world_role, character: [:photo_attachment]]
    )
    if params[:search].present?
      @organizations = @organizations.search(params[:search])
    end
    @organizations = @organizations.order("#{sort_column} #{sort_order}")
    @organizations = @organizations.paginate(page: params[:page],
                                             per_page: Organization::PER_PAGE)
    render json: serialize_rec(@organizations).merge!(
      pagination_hsh(@organizations, Organization)
    )
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
    @select_characters = Character.find(params[:character_id])
                                  .organization_characters.pluck(:organization_id)
    @orgs = Organization.with_attached_photo.includes(:industry,
                                                      :organization_characters, characters: [:photo_attachment])
    @orgs = @orgs.where.not(id: @select_characters)
    @orgs = @orgs.search(params[:search]) if params[:search].present?
    @orgs = @orgs.paginate(page: params[:page], per_page: Organization::PER_PAGE)
    render json: serialize_rec(@orgs).merge!(pagination_without_sort_hsh(
                                               @orgs, Organization
                                             ))
  end

  swagger_controller :organizations, 'organization', resource_path: '/api/admin/v1/organizations'

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
    param :form, 'organization[industry_attributes][name]', :string, :optional, 'industry name'
    param :form, 'organization[organization_characters_attributes][][id]', :integer, :optional, 'organization_characters_id'
    param :form, 'organization[organization_characters_attributes][][character_id]', :integer, :optional, 'character_id'
    param :form, 'organization[organization_characters_attributes][][world_role_id]', :string, :required, 'world_role_id'
    param :form, 'organization[organization_characters_attributes][][_destroy]', :boolean, :optional, 'set to true to delete record'
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
    param :form, 'organization[industry_attributes][name]', :string, :optional, 'industry name'
    param :form, 'organization[organization_characters_attributes][][id]', :integer, :optional, 'organization_characters_id'
    param :form, 'organization[organization_characters_attributes][][character_id]', :integer, :optional, 'character_id'
    param :form, 'organization[organization_characters_attributes][][world_role_id]', :string, :required, 'world_role_id'
    param :form, 'organization[organization_characters_attributes][][_destroy]', :boolean, :optional, 'set to true to delete record'
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
    params.require(:organization).permit(:name, :description, :photo,
                                         industry_attributes: [:name], organization_characters_attributes: %i[id
                                                                                                              character_id world_role_id _destroy])
  end

  def serializer
    OrganizationWithCharacterSerializer
  end

  # Set default sort Column
  def sort_column
    valid_sort && params[:sort_column] || 'organizations.id'
  end

  # Validate sort key & set default sort type
  def sort_order
    sort_ord = params[:sort_order]
    sort_ord.present? && %w[asc desc].include?(sort_ord) && sort_ord || 'desc'
  end

  # Verify available sort options
  def valid_sort
    params[:sort_column].present? && ['organizations.name', 'created_at',
                                      'industries.name', 'characters_count'].include?(params[:sort_column])
  end
end
