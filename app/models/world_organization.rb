# == Schema Information
#
# Table name: world_organizations
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  world_id        :bigint           not null
#
# Indexes
#
#  index_world_organizations_on_organization_id  (organization_id)
#  index_world_organizations_on_world_id         (world_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (world_id => worlds.id)
#
class WorldOrganization < ApplicationRecord

  belongs_to :world
  belongs_to :organization

  has_many :world_org_characters, dependent: :destroy
  has_many :characters, through: :world_org_characters

  accepts_nested_attributes_for :world_org_characters

end
