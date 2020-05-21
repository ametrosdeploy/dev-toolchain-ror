# frozen_string_literal: true

class Api::Admin::V1::WorldRolesController < Api::Admin::V1::BaseController
  include PaginateHsh
  before_action :authenticate_user!
  before_action :set_world_role, only: %i[show update destroy]

  WORLD_ROLE_ID = 'world_role Id'

  def index
    @world_roles = WorldRole.all
    render json: serialize_rec(@world_roles)
  end

  def show
    render json: serialize_rec(@world_role)
  end

  def create
    @world_role = WorldRole.new(world_role_params)

    if @world_role.save
      render json: serialize_rec(@world_role), status: :created
    else
      render json: @world_role.errors, status: :unprocessable_entity
    end
  end

  def update
    if @world_role.update(world_role_params)
      render json: serialize_rec(@world_role)
    else
      render json: @world_role.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @world_role.destroy
  end

  # Needed to auto complete customer data
  def auto_comp_data
    @world_roles = WorldRole.all
    if params[:search].present?
      @world_roles = @world_roles.where('name ilike ?', "%#{params[:search]}%")
    end
    @world_roles = @world_roles.paginate(page: params[:page], per_page: 5)
    render json: serialize_rec(@world_roles).merge!(
      pagination_without_sort_hsh(@world_roles, WorldRole)
    )
  end

  swagger_controller :world_roles, 'WorldRole', resource_path:
    '/api/admin/v1/world_roles'

  swagger_api :auto_comp_data do
    summary 'world role auto complete data'
    notes 'Should be used to auto complete world role data'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
  end

  swagger_api :index do
    summary 'List world_roles'
    notes 'Should be used to List world_roles'
    param :header, :Authorization, :string, :required, 'Authorization'
  end

  swagger_api :create do
    summary 'Creates a new world_role'
    notes 'Should be used to create world_role'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'world_role[name]', :string, :required, 'name'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show world_role'
    notes 'Should be used to Show world_role'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, WORLD_ROLE_ID
  end

  swagger_api :update do
    summary 'Update world_role'
    notes 'Should be used to Update world_role'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, WORLD_ROLE_ID
    param :form, 'world_role[name]', :string, :required, 'name'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy a world_role'
    notes 'Should be used to destroy a world_role'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, WORLD_ROLE_ID
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_world_role
    @world_role = WorldRole.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def world_role_params
    params.require(:world_role).permit(:name)
  end

  def serializer
    WorldRoleSerializer
  end
end
