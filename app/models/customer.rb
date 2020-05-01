class Customer < ApplicationRecord
  PER_PAGE = 10
  has_many :worlds
  validates :name, :email, presence: true

end
