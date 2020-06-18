# frozen_string_literal: true

module Learner
  # USer section serializer
  class UserSectionSerializer
    include FastJsonapi::ObjectSerializer
    include DateHelper
    include ImageHelper
    attributes :completed_count, :status, :complete_percentage

    attribute :total_count do |user_section|
      user_section.user_learn_objs.size
    end

    attribute :time_started do |user_section|
      format_to_ymd(user_section.time_started)
    end

    attribute :time_completed do |user_section|
      format_to_ymd(user_section.time_completed)
    end
  end
end
