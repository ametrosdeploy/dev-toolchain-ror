# frozen_string_literal: true

class LearnerDashSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  attributes :title, :description, :welcome_text

  attribute :welcome_img do |learner_dash|
    image_url(learner_dash.welcome_img)
  end
end
