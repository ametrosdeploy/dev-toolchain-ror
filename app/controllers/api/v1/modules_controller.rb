# frozen_string_literal: true

# Learner modules
class Api::V1::ModulesController < Api::V1::BaseController
  before_action :set_learn_mod, only: %i[show update destroy]

  def index
    @learn_mods = UserSection.joins(:learn_mod)
                             .includes([learn_mod: :photo_attachment])
                             .where(user_id: current_user.id)
    filter_learn_mod
    render json: serialize_rec(@learn_mods)
  end

  swagger_controller :modules, 'Module', resource_path: '/api/v1/modules'

  swagger_api :index do
    summary 'List modules'
    notes 'Should be used to List modules'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'type', :string, :optional, 'Options: "active", "completed",
          "expired"'
  end

  private

  def data_type
    valid_types.include?(params[:type]) || 'active'
  end

  def valid_types
    %w[active completed expired]
  end

  def serializer
    Learner::UserSectionWithLearnModSerializer
  end

  def filter_learn_mod
    @learn_mods = if params[:type] == 'completed'
                    @learn_mods.where('time_completed is not null')
                  else
                    @learn_mods.where('time_completed is null')
                  end
  end
end
