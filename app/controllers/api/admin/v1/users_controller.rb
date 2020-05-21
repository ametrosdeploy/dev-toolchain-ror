# frozen_string_literal: true

# Controller for users related requests
class Api::Admin::V1::UsersController < Api::Admin::V1::BaseController
  include PaginateHsh
  before_action :authenticate_user!
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  # Needed to auto complete SME & Lead Designer
  def users_list
    if get_user_role
      @users = User.with_role(get_user_role)
      @users = @users.search(params[:search]) if params[:search].present?
      @users = @users.paginate(page: params[:page], per_page: User::PER_PAGE)
      render json: serialize_rec(@users).merge!(
        pagination_without_sort_hsh(@users, User)
      )
    else
      render json: invalid_role, status: :unprocessable_entity
    end
  end

  swagger_controller :users, 'User', resource_path: '/api/admin/v1/users'

  swagger_api :users_list do
    summary 'User auto complete data'
    notes 'Should be used to auto complete User data'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
    param :query, 'user_type', :string, :required, 'user_type Options: "sme",
                                                                "lead_designer"'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:world).permit(:first_name, :email)
  end

  def serializer
    UserSerializer
  end

  # Validates users so that only sme & lead_designer are returned
  def get_user_role
    valid_roles.include?(params[:user_type].to_sym) && params[:user_type].to_sym
  end

  def valid_roles
    %i[sme lead_designer]
  end

  def invalid_role
    { error: 'Invalid user role.' }
  end
end
