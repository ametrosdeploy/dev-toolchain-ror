class WorldOrganization < ApplicationRecord
  # Associations ...
  belongs_to :world
  belongs_to :organization
  belongs_to :industry

  has_many :world_organization_characters
end
