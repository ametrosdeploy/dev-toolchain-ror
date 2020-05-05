class OrganizationCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :organization
  belongs_to :world_role
end
