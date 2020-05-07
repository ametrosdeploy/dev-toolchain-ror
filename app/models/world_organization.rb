# == Schema Information
#
# Table name: world_organizations
#
#  id              :bigint           not null, primary key
#  world_id        :bigint           not null
#  organization_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class WorldOrganization < ApplicationRecord

  belongs_to :world
  belongs_to :organization

  has_many :world_org_characters, dependent: :destroy
  has_many :characters, through: :world_org_characters

  accepts_nested_attributes_for :world_org_characters

end
