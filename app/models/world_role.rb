class WorldRole < ApplicationRecord
  PER_PAGE = 10
  validates :name, presence: true

  has_many :world_org_characters
  has_many :organization_characters

end
