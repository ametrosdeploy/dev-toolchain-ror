class Industry < ApplicationRecord
  PER_PAGE = 10
  has_many :organizations

  validates :name, presence: true
end
