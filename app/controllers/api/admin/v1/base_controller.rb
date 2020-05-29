# frozen_string_literal: true

# Base controller for V1 Admin
class Api::Admin::V1::BaseController < Api::ApplicationController
  before_action :authenticate_user!
  before_action :admin_only

  def admin_only
    return if current_user.has_role? :admin

    render status: 401, json: {
      error: 'You are not authorized to perform this action'
    }
  end
end
