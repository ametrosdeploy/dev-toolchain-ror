# frozen_string_literal: true

# Controller for Assessment Schemes creation
class Api::Admin::V1::AssessmentSchemesController < Api::Admin::V1::BaseController
  before_action :set_assessment_scheme, only: %i[show update destroy]

  # GET /assessment_schemes
  def index
    @assessment_schemes = AssessmentScheme.all
    render json: serialize_rec(@assessment_schemes)
  end

  # GET /assessment_schemes/1
  def show
    render json: serialize_rec(@assessment_scheme)
  end

  # POST /assessment_schemes
  def create
    @assessment_scheme = AssessmentScheme.new(assessment_scheme_params)

    if @assessment_scheme.save
      render json: serialize_rec(@assessment_scheme), status: :created
    else
      render json: @assessment_scheme.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /assessment_schemes/1
  def update
    if @assessment_scheme.update(assessment_scheme_params)
      render json: serialize_rec(@assessment_scheme)
    else
      render json: @assessment_scheme.errors, status: :unprocessable_entity
    end
  end

  # DELETE /assessment_schemes/1
  def destroy
    @assessment_scheme.destroy
  end

  swagger_controller :assessment_schemes, 'AssessmentScheme', resource_path:
    '/api/admin/v1/assessment_schemes'

  swagger_api :index do
    summary 'List All Assessment Schemes'
    notes 'Should be used to List Assessment Schemes'
    param :header, :Authorization, :string, :required, 'Authorization'
    # param :query, 'page', :string, :optional, 'Page Number'
    # param :query, 'search', :string, :optional, 'Search Parameter'
    # param :query, 'sort_column', :string, :optional, 'Options: "assessment_schemes.name"
    # , "created_at"'
    # param :query, 'sort_order', :string, :optional, 'Options: "asc", "desc"'
  end

  swagger_api :create do
    summary 'Creates an assessment Scheme'
    notes 'Should be used to create an assessment Scheme'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'assessment_scheme[name]', :string, :required, 'name'
    param :form, 'assessment_scheme[assessment_labels_attributes][][id]',
          :integer, :optional, 'Label Id'
    param :form, 'assessment_scheme[assessment_labels_attributes][][name]',
          :string, :optional, 'Label Name'
    param :form, 'assessment_scheme[assessment_labels_attributes][][order]',
          :integer, :optional, 'Label Order'
    param :form, 'assessment_scheme[assessment_labels_attributes][][icon]',
          :string, :optional, 'Label Icon'
    param :form, 'assessment_scheme[assessment_labels_attributes][]
    [_destroy]', :boolean, :optional, 'Set this to true to remove'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show an assessment Scheme'
    notes 'Should be used to Show an assessment Scheme'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'Scheme Id'
  end

  swagger_api :update do
    summary 'Updates an assessment Scheme'
    notes 'Should be used to update an assessment Scheme'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'Scheme Id'
    param :form, 'assessment_scheme[name]', :string, :required, 'name'
    param :form, 'assessment_scheme[assessment_labels_attributes][][id]',
          :integer, :optional, 'Label Id'
    param :form, 'assessment_scheme[assessment_labels_attributes][][name]',
          :string, :optional, 'Label Name'
    param :form, 'assessment_scheme[assessment_labels_attributes][][order]',
          :integer, :optional, 'Label Order'
    param :form, 'assessment_scheme[assessment_labels_attributes][][icon]',
          :string, :optional, 'Label Icon'
    param :form, 'assessment_scheme[assessment_labels_attributes][]
    [_destroy]', :boolean, :optional, 'Set this to true to remove'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy an assessment Scheme'
    notes 'Should be used to destroy an assessment Scheme'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'Scheme Id'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_assessment_scheme
    @assessment_scheme = AssessmentScheme.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def assessment_scheme_params
    params.require(:assessment_scheme).permit(
      :name,
      assessment_labels_attributes: %i[id name order icon _destroy]
    )
  end

  def serializer
    AssessmentSchemeSerializer
  end
end
