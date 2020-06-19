# frozen_string_literal: true

# Controller o manage Genders
class Api::Admin::V1::GendersController < Api::Admin::V1::BaseController
  before_action :set_gender, only: %i[show update destroy]

  GENDER_ID = 'Gender Id'

  def index
    @genders = Gender.all
    render json: serialize_rec(@genders)
  end

  def show
    render json: serialize_rec(@gender)
  end

  def create
    @gender = Gender.new(gender_params)
    if @gender.save
      render json: serialize_rec(@gender), status: :created
    else
      render json: @gender.errors, status: :unprocessable_entity
    end
  end

  def update
    if @gender.update(gender_params)
      render json: serialize_rec(@gender)
    else
      render json: @gender.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @gender.destroy
  end

  swagger_controller :genders, 'Gender', resource_path:
   '/api/admin/v1/genders'

  swagger_api :index do
    summary 'List genders'
    notes 'Should be used to List genders'
    param :header, :Authorization, :string, :required, 'Authorization'
  end

  swagger_api :create do
    summary 'Creates a new gender'
    notes 'Should be used to create gender'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'gender[name]', :string, :required, 'name'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show gender'
    notes 'Should be used to show gender'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, GENDER_ID
  end

  swagger_api :update do
    summary 'Update gender'
    notes 'Should be used to update gender'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, GENDER_ID
    param :form, 'gender[name]', :string, :required, 'name'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy a gender'
    notes 'Should be used to destroy a gender'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, GENDER_ID
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gender
    @gender = Gender.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def gender_params
    params.require(:gender).permit(:name)
  end

  def serializer
    GenderSerializer
  end
end
