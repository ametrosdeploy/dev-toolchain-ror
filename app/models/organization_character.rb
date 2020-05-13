# == Schema Information
#
# Table name: organization_characters
#
#  id              :bigint           not null, primary key
#  character_id    :bigint           not null
#  organization_id :bigint           not null
#  world_role_id   :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class OrganizationCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :organization
  belongs_to :world_role

  validates_uniqueness_of :character_id, scope: %i[organization_id world_role_id]

  scope :limited_org_chars, lambda { |car_list|
                              where('character_id not in (?)',
                                    car_list)
                            }
end
