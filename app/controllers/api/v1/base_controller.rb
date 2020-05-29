# frozen_string_literal: true

module Api
  module V1
    # Base Controller for Learner
    class BaseController < Api::ApplicationController
      before_action :authenticate_user!
      before_action :learner_only

      def learner_only
        return if current_user.has_role? :learner

        render status: 401, json: {
          error: 'You are not authorized to perform this action'
        }
      end
    end
  end
end
