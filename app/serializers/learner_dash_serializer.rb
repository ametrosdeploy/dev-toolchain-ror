# frozen_string_literal: true

# == Schema Information
#
# Table name: learner_dashes
#
#  id           :bigint           not null, primary key
#  title        :string
#  description  :text
#  welcome_text :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class LearnerDashSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  attributes :title, :description, :welcome_text

  attribute :welcome_img do |learner_dash|
    image_url(learner_dash.welcome_img)
  end
end
