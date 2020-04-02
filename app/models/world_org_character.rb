class WorldOrgCharacter < ApplicationRecord
  belongs_to :world_organization_role
  belongs_to :character
end
