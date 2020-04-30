class WorldRole < ApplicationRecord
  PER_PAGE = 10
  validates :name, presence: true

end
