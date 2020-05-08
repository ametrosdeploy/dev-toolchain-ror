class OrganizationCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :organization
  belongs_to :world_role

  scope :limited_org_chars, -> (car_list) { where("character_id not in (?)",
                                                                     car_list) }

end
