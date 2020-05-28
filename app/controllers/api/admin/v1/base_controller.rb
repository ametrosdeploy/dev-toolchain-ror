# frozen_string_literal: true

# Base controller for V1 Admin
class Api::Admin::V1::BaseController < Api::ApplicationController
  before_action :authenticate_user!
end
