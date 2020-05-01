class Api::Admin::V1::WorldsController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_world, only: %i[show update destroy assign_organization_role]

  def index
    @worlds = World.includes(:customer, world_organizations: [ :world_org_characters,
       organization: [:photo_attachment, :industry],
       characters: [:photo_attachment]])
    @worlds = @worlds.where("name ilike :lsearch or world_code = :search or 
      description ilike :lsearch", search: params[:search].delete("^0-9").to_i, lsearch: 
      "%#{params[:search]}%") if params[:search].present?
    @worlds = @worlds.order("#{sort_column} #{sort_order}")
    @worlds = @worlds.paginate(page: params[:page], per_page: 10)
    render json: serialize_rec(@worlds).merge!(pagination_hsh(@worlds, World))
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

  def assign_organization_role
    @org_character = @world.word_organizations.build(world_organization_params)
    if @org_character.save
      render json: @org_character, status: 200
    else
      render json: @org_character.errors, status: :unprocessable_entity
    end
  end

  def assign_organization_role
    word_organizations = @world.word_organizations
    @world.destroy

  end

  swagger_controller :worlds, 'World', resource_path: '/api/admin/v1/worlds'

  swagger_api :index do
    summary 'List worlds'
    notes 'Should be used to List worlds'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
    param :query, 'sort_column', :string, :optional, 'Options: "name", "created_at",
     "is_private", "learn_mods_count"'
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
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show world'
    notes 'Should be used to Show world'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'World Id'
  end

  swagger_api :update do
    summary 'Update World'
    notes 'Should be used to Update World'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'World Id'
    param :form, 'world[name]', :string, :required, 'name'
    param :form, 'world[description]', :string, :optional, 'description'
    param :form, 'world[customer_id]', :integer, :optional, 'customer_id'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroys a World'
    notes 'Should be used to destroy a World'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'World Id'
  end

  swagger_api :assign_organization_role do
    summary 'Assign organization and role to character'
    notes 'Should be used to assign organization and role to character'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'World Id'
    param :form, 'world_organization[organization_id]', :string, :required, 'organization_id'
    param :form, 'world_organization[world_org_characters_attributes][][character_id]', :integer, :optional, 'character_id'
    param :form, 'world_organization[world_org_characters_attributes][][world_role_id]', :string, :required, 'world_role_id'
    response :unauthorized
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_world
    @world = World.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def world_params
    params.require(:world).permit(:name, :description, :customer_id,
                                  :is_private)
  end

  def world_organization_params_params
    params.require(:world_organization).permit(:organization_id,  world_org_characters_attributes:[:world_role_id] )
    params.require(:organization_character).permit(:organization_id, :world_role_id)
  end

  def serializer
    WorldSerializer
  end

  def sort_column
    valid_sort && params[:sort_column] || 'id'
  end

  def sort_order
    sort_type = params[:sort_type]
    sort_type.present? && %w[asc desc].include?(sort_type) && sort_type || 'desc'
  end

  def valid_sort
    params[:sort_column].present? && %w[name created_at is_private learn_mods_count].include?(params[:sort_column])
  end
end
