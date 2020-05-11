class WorldOrgCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :world_organization
  belongs_to :world_role

  validates_uniqueness_of :character_id, scope: [:world_organization_id,
                                                 :world_role_id]

end
