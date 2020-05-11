# == Schema Information
#
# Table name: world_org_characters
#
#  id                    :bigint           not null, primary key
#  world_organization_id :bigint           not null
#  character_id          :bigint           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  world_role_id         :bigint           not null
#
class WorldOrgCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :world_organization
  belongs_to :world_role

  validates_uniqueness_of :character_id, scope: [:world_organization_id,
                                                 :world_role_id]

end
