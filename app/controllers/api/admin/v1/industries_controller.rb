# frozen_string_literal: true

# Industries controller
class Api::Admin::V1::IndustriesController < Api::Admin::V1::BaseController
  include PaginateHsh
  before_action :authenticate_user!
  before_action :set_industry, only: %i[show update destroy]
  INDUSTRY_ID = 'industry Id'

  def index
    @industries = Industry.all
    render json: serialize_rec(@industries)
  end

  def show
    render json: serialize_rec(@industry)
  end

  def create
    @industry = Industry.new(industry_params)

    if @industry.save
      render json: serialize_rec(@industry), status: :created
    else
      render json: @industry.errors, status: :unprocessable_entity
    end
  end

  def update
    if @industry.update(industry_params)
      render json: serialize_rec(@industry)
    else
      render json: @industry.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @industry.destroy
  end

  # Needed to auto complete Industry data
  def auto_comp_data
    @industries = Industry.all
    if params[:search].present?
      @industries = @industries.where('name ilike ?', "%#{params[:search]}%")
    end
    @industries = @industries.paginate(page: params[:page], per_page: 5)
    render json: serialize_rec(@industries).merge!(
      pagination_without_sort_hsh(@industries, Industry)
    )
  end

  swagger_controller :industries, 'Industry', resource_path:
    '/api/admin/v1/industries'

  swagger_api :auto_comp_data do
    summary 'Industry auto complete data'
    notes 'Should be used to auto complete Industry data'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
  end

  swagger_api :index do
    summary 'List industries'
    notes 'Should be used to List industries'
    param :header, :Authorization, :string, :required, 'Authorization'
  end

  swagger_api :create do
    summary 'Creates a new industry'
    notes 'Should be used to create industry'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'industry[name]', :string, :required, 'name'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show industry'
    notes 'Should be used to Show industry'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, INDUSTRY_ID
  end

  swagger_api :update do
    summary 'Update industry'
    notes 'Should be used to Update industry'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, INDUSTRY_ID
    param :form, 'industry[name]', :string, :required, 'name'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy a industry'
    notes 'Should be used to destroy a industry'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, INDUSTRY_ID
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_industry
    @industry = Industry.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def industry_params
    params.require(:industry).permit(:name)
  end

  def serializer
    IndustrySerializer
  end
end
