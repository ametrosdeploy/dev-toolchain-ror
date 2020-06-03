# frozen_string_literal: true

# Controller to manage UserSections related requests
class Api::Admin::V1::UserSectionsController < Api::Admin::V1::BaseController
  before_action :set_user_section, only: %w[show update destroy]
  USER_SECTION_ID = 'user_section id'

  def index
    @user_sections = UserSection.all
    render json: serialize_rec(@user_sections)
  end

  def show
    render json: serialize_rec(@user_section)
  end

  def create
    @user_section = UserSection.new(user_section_params)

    if @user_section.save
      render json: serialize_rec(@user_section), status: :created
    else
      render json: @user_section.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user_section.update(user_section_params)
      render json: serialize_rec(@user_section)
    else
      render json: @user_section.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user_section.destroy
  end

  swagger_controller :user_sections, 'UserSection', resource_path:
    '/api/admin/v1/user_sections'

  swagger_api :index do
    summary 'List user_sections'
    notes 'Should be used to List user_sections'
    param :header, :Authorization, :string, :required, 'Authorization'
  end

  swagger_api :create do
    summary 'Creates a new user_sections'
    notes 'Should be used to create a user_sections'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'user_section[user_id]', :string, :required, 'user_id'
    param :form, 'user_section[section_id]', :string, :required, 'section_id'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show user_section'
    notes 'Should be used to Show user_section'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, USER_SECTION_ID
  end

  swagger_api :update do
    summary 'Update user_sections'
    notes 'Should be used to Update user_sections'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, USER_SECTION_ID
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'user_section[user_id]', :string, :required, 'user_id'
    param :form, 'user_section[section_id]', :string, :required, 'section_id'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy a user_section'
    notes 'Should be used to destroy a user_section'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, USER_SECTION_ID
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_section
    @user_section = UserSection.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_section_params
    params.require(:user_section).permit(:user_id, :section_id)
  end

  def serializer
    UserSectionSerializer
  end
end
