# frozen_string_literal: true

class LearnerDash < ApplicationRecord
  strip_attributes

  has_one_attached :welcome_img

  validates :title, :description, :welcome_text, presence: true
end
