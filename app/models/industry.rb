# frozen_string_literal: true

# == Schema Information
#
# Table name: industries
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Industry < ApplicationRecord
  PER_PAGE = 10
  strip_attributes
  has_many :organizations

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false
end
