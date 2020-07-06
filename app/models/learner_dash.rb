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
class LearnerDash < ApplicationRecord
  strip_attributes

  has_one_attached :welcome_img

  validates :title, :description, :welcome_text, presence: true
end
