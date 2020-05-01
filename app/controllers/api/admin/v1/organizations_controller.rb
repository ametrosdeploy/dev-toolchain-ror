class Api::Admin::V1::OrganizationsController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_organization, only: [:show, :update, :destroy]

  def index
    @organizations = Organization.with_attached_photo.includes(:industry, :organization_characters, 
                                                      characters: [:photo_attachment, :photo_blob])
    @organizations = @organizations.where("name ilike :search or description 
      ilike :search or industries.name ilike :search", search: "%#{params[:search]}%"
      ) if params[:search].present?
    @organizations = @organizations.order("#{sort_column} #{sort_order}")
    @organizations = @organizations.paginate(page: params[:page], per_page: 3)
    render json: serialize_rec(@organizations).merge!(pagination_hsh(@organizations, Organization))
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

  swagger_controller :organizations, 'organization', resource_path: '/api/admin/v1/organizations'

  swagger_api :index do
    summary 'List organizations'
    notes 'Should be used to List organizations'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
    param :query, 'sort_column', :string, :optional, 'Options: "name", "created_at", 
    "industries.name", "characters_count"'
    param :query, 'sort_order', :string, :optional, 'Options: "asc", "desc"'
  end

  swagger_api :create do
    summary 'Creates a new organization'
    notes 'Should be used to create organization'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'organization[name]', :string, :required, 'name'
    param :form, 'organization[description]', :string, :optional, 'description'
    param :form, 'organization[industry_id]', :integer, :optional, 'industry_id'
    param :form, 'organization[organization_characters_attributes][][character_id]', :integer, :optional, 'character_id'
    param :form, 'organization[organization_characters_attributes][][character_role]', :string, :required, 'character_role'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show organization'
    notes 'Should be used to Show organization'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'organization Id'
  end

  swagger_api :update do
    summary 'Update organization'
    notes 'Should be used to Update organization'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'organization Id'
    param :form, 'organization[name]', :string, :required, 'name'
    param :form, 'organization[description]', :string, :optional, 'description'
    param :form, 'organization[industry_id]', :integer, :optional, 'industry_id'
    param :form, 'organization[organization_characters_attributes][][character_id]', :integer, :optional, 'character_id'
    param :form, 'organization[organization_characters_attributes][][character_role]', :string, :required, 'character_role'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroys a organization'
    notes 'Should be used to destroy a organization'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'organization Id'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def organization_params
      params.require(:organization).permit(:name, :description, :industry_id, organization_characters_attributes: [:character_id, :character_role] )
    end

    def serializer
      OrganizationSerializer
    end

    def sort_column
      valid_sort && params[:sort_column] || "id"
    end

    def sort_order
      sort_type = params[:sort_order]
      sort_type.present? && ["asc", "desc"].include?(sort_type) && sort_type || "desc"
    end

    def valid_sort
      params[:sort_column].present? && ["name", "created_at", "industries.name", "characters_count"
      ].include?(params[:sort_column])
    end

end
