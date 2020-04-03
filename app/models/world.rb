class World < ApplicationRecord
  # Associations ...
  belongs_to :customer, optional: true # Present only for private worlds ...

  has_many :world_organizations
  has_many :organizations, through: :world_organizations
end
