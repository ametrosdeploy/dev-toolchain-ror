class WorldOrgCharacter < ApplicationRecord
  belongs_to :world_organization
  belongs_to :world_role
  belongs_to :character
end
