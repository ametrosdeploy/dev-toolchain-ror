# frozen_string_literal: true

# Session Controller for Admin/User Login
class Api::V1::SessionsController < Devise::SessionsController
  include Swagger::Docs::ImpotentMethods
  skip_before_action :verify_signed_out_user, only: [:destroy]
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource, store: false)
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  swagger_controller :sessions, 'Session', resource_path: '/api/v1/users/login'

  swagger_api :create do
    summary 'Creates a new Session'
    notes 'Should be used for user login'
    param :form, 'user[email]', :string, :required, 'Email address'
    param :form, 'user[password]', :string, :required, 'Password'
    response :unauthorized
  end

  private

  def respond_with(resource, _opts = {})
    render json: { users: resource,
                   authorization_token: "Bearer #{request
                   .headers['warden-jwt_auth.token']}" }
  end

  def respond_to_on_destroy
    head :ok
  end
end
