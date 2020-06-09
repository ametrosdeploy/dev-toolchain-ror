# frozen_string_literal: true

module Learner
  # USer section serializer
  class UserSectionSerializer
    include FastJsonapi::ObjectSerializer
    include DateHelper
    include ImageHelper
    attributes :completed_count, :status

    attribute :time_started do |user_section|
      format_to_ymd(user_section.time_started)
    end

    attribute :time_completed do |user_section|
      format_to_ymd(user_section.time_completed)
    end
  end
end
