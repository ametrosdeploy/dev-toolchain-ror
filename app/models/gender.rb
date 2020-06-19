# frozen_string_literal: true

# Gender Model
class Gender < ApplicationRecord
  has_many :characters
end
