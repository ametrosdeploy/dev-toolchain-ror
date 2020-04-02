class WorldOrganization < ApplicationRecord
  belongs_to :world
  belongs_to :organization
  belongs_to :industry
end
