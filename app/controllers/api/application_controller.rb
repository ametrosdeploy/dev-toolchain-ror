# frozen_string_literal: true

module Api
  # Main API Application controller
  class ApplicationController < ActionController::API
    include Pundit
    Swagger::Docs::Generator.set_real_methods

    def serialize_rec(data)
      serializer.new(data).serializable_hash
    end

    def render_invalid_access
      render status: 401, json: { error: I18n.t(:invalid_access) }
    end
  end
end
