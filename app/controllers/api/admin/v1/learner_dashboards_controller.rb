# frozen_string_literal: true

# Controller for learner Dashboard
class Api::Admin::V1::LearnerDashboardsController < Api::Admin::V1::BaseController
  before_action :set_learner_dash, only: %i[show update destroy]
  DASHBOARD_ID = 'learner dashboard Id'

  def index
    @learner_dash = LearnerDash.first
    render json: serialize_rec(@learner_dash)
  end

  def show
    render json: serialize_rec(@learner_dash)
  end

  def create
    # User first record or build a new one
    @learner_dash = LearnerDash.first || LearnerDash.new
    @learner_dash.assign_attributes(learner_dash_params)
    if @learner_dash.save
      render json: @learner_dash, status: :created
    else
      render json: @learner_dash.errors, status: :unprocessable_entity
    end
  end

  def update
    if @learner_dash.update(learner_dash_params)
      render json: @learner_dash
    else
      render json: @learner_dash.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @learner_dash.destroy
  end

  swagger_controller :learner_dashboards, 'LearnerDash', resource_path:
    '/api/admin/v1/learner_dashboards'

  swagger_api :index do
    summary 'List learner dashboards'
    notes 'Should be used to List learner dashboards'
    param :header, :Authorization, :string, :required, 'Authorization'
  end

  swagger_api :create do
    summary 'Creates a new learner dashboard'
    notes 'Should be used to create learner dashboard'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'learner_dash[title]', :string, :required, 'title'
    param :form, 'learner_dash[description]', :string, :required, 'description'
    param :form, 'learner_dash[welcome_text]', :string, :required,
          'welcome_text'
    param :form, 'learner_dash[welcome_img]', :string, :optional, 'welcome_img'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show learner dashboard'
    notes 'Should be used to Show learner dashboard'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, DASHBOARD_ID
  end

  swagger_api :update do
    summary 'Update learner dashboard'
    notes 'Should be used to Update learner dashboard'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, DASHBOARD_ID
    param :form, 'learner_dash[title]', :string, :required, 'title'
    param :form, 'learner_dash[description]', :string, :required, 'description'
    param :form, 'learner_dash[welcome_text]', :string, :required,
          'welcome_text'
    param :form, 'learner_dash[welcome_img]', :string, :optional, 'welcome_img'
    response :unauthorized
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_learner_dash
    @learner_dash = LearnerDash.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def learner_dash_params
    params.require(:learner_dash).permit(:title, :description, :welcome_text,
                                         :welcome_img)
  end

  def serializer
    LearnerDashSerializer
  end
end
