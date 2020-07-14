# frozen_string_literal: true

module Learner
  # User section with learn_mod data serializer
  class UserSubmissionSerializer
    include FastJsonapi::ObjectSerializer
    include ImageHelper
    attributes :user_text, :user_learn_obj_id

    attribute :attachment_url do |submission|
      image_url(submission.attachment)
    end
  end
end
