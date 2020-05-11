class WorldOrganization < ApplicationRecord

  belongs_to :world
  belongs_to :organization

  has_many :world_org_characters, dependent: :destroy
  has_many :characters, through: :world_org_characters

  validates_uniqueness_of :world_id, scope: [ :organization_id ]
  accepts_nested_attributes_for :world_org_characters

end
