class OrganizationCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :organization
  belongs_to :world_role

  validates_uniqueness_of :character_id, scope: [:organization_id, :world_role_id]

  scope :limited_org_chars, -> (car_list) { where("character_id not in (?)",
                                                                     car_list) }

end
