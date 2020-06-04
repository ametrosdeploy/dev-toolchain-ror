# frozen_string_literal: true

# Learner Dashboard page
class Api::V1::LearnerDashboardsController < Api::V1::BaseController
  def index
    @learner_dash = LearnerDash.first
    render json: serialize_rec(@learner_dash)
  end

  swagger_controller :learner_dashboards, 'LearnerDash', resource_path:
    '/api/v1/learner_dashboards'

  swagger_api :index do
    summary 'Learner dashboard page'
    notes 'Should be used for Learner dashboard page content'
    param :header, :Authorization, :string, :required, 'Authorization'
  end

  private

  def serializer
    LearnerDashSerializer
  end
end
