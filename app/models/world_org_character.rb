# == Schema Information
#
# Table name: world_org_characters
#
#  id                    :bigint           not null, primary key
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  character_id          :bigint           not null
#  world_organization_id :bigint           not null
#  world_role_id         :bigint           not null
#
# Indexes
#
#  character_id_world_organization_id_world_role_id     (character_id,world_organization_id,world_role_id) UNIQUE
#  index_world_org_characters_on_character_id           (character_id)
#  index_world_org_characters_on_world_organization_id  (world_organization_id)
#  index_world_org_characters_on_world_role_id          (world_role_id)
#
# Foreign Keys
#
#  fk_rails_...  (character_id => characters.id)
#  fk_rails_...  (world_organization_id => world_organizations.id)
#  fk_rails_...  (world_role_id => world_roles.id)
#
class WorldOrgCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :world_organization
  belongs_to :world_role
end
