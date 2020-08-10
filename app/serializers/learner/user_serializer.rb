# frozen_string_literal: true

module Learner
  # Learner profile serializer
  class UserSerializer
    include FastJsonapi::ObjectSerializer
    attributes :full_name, :email

    attribute :profile_url do |profile|
      # Setting profile to false
      false
    end
  end
end
