class WorldOrgCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :world_organization
  belongs_to :world_role
end
