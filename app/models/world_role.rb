# == Schema Information
#
# Table name: world_roles
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class WorldRole < ApplicationRecord
  PER_PAGE = 10
  validates :name, presence: true

  has_many :world_org_characters
  has_many :organization_characters

end
