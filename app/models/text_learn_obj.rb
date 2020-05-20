# frozen_string_literal: true

class TextLearnObj < ApplicationRecord
  has_one :learning_object, as: :objectable
  has_one :learn_mod, through: :learning_objects
  validates :title, presence: true
end
