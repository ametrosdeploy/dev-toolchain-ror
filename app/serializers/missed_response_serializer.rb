# frozen_string_literal: true

class MissedResponseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :response
end
