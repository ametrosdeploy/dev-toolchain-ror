# frozen_string_literal: true

# Controller to manage section related requests
class Api::Admin::V1::SectionsController < Api::Admin::V1::BaseController
  before_action :set_section, only: %w[show update destroy]
  SECTION_ID = 'section Id'

  def index
    @sections = Section.all
    render json: serialize_rec(@sections)
  end

  def show
    render json: @section
  end

  def create
    @section = Section.new(section_params)

    if @section.save
      render json: serialize_rec(@section), status: :created
    else
      render json: @section.errors, status: :unprocessable_entity
    end
  end

  def update
    if @section.update(section_params)
      render json: serialize_rec(@section)
    else
      render json: @section.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @section.destroy
  end

  swagger_controller :sections, 'Section', resource_path:
    '/api/admin/v1/sections'

  swagger_api :index do
    summary 'List sections'
    notes 'Should be used to List sections'
    param :header, :Authorization, :string, :required, 'Authorization'
  end

  swagger_api :create do
    summary 'Creates a new sections'
    notes 'Should be used to create a sections'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'section[cutomer_learn_mod_attributes][customer_id]',
          :string, :required, 'customer_id'
    param :form, 'section[cutomer_learn_mod_attributes][learn_mod_id]',
          :string, :required, 'learn_mod_id'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show sections'
    notes 'Should be used to Show section'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, SECTION_ID
  end

  swagger_api :update do
    summary 'Update sections'
    notes 'Should be used to Update sections'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, SECTION_ID
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'section[cutomer_learn_mod_attributes][customer_id]',
          :string, :required, 'customer_id'
    param :form, 'section[cutomer_learn_mod_attributes][learn_mod_id]',
          :string, :required, 'learn_mod_id'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroy a section'
    notes 'Should be used to destroy a section'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, SECTION_ID
  end

  private

  def set_section
    @section = Section.find(params[:id])
  end

  def section_params
    params.require(:section)
          .permit(cutomer_learn_mod_attributes: %i[customer_id learn_mod_id])
  end

  def serializer
    SectionSerializer
  end
end
