# == Schema Information
#
# Table name: organizations
#
#  id               :bigint           not null, primary key
#  characters_count :integer          default(0)
#  description      :text
#  name             :string           not null
#  real_world       :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  industry_id      :bigint           not null
#
# Indexes
#
#  index_organizations_on_industry_id  (industry_id)
#
# Foreign Keys
#
#  fk_rails_...  (industry_id => industries.id)
#
class Organization < ApplicationRecord
  PER_PAGE = 10

  belongs_to :industry, autosave: true

  has_many :world_organizations, dependent: :destroy
  has_many :worlds, through: :world_organizations, dependent: :destroy

  has_many :organization_characters, dependent: :destroy
  has_many :characters, through: :organization_characters, dependent: :destroy

  accepts_nested_attributes_for :world_organizations
  accepts_nested_attributes_for :organization_characters

  has_one_attached :photo

  validates :name, :industry_id, presence: true
  validates_uniqueness_of :name, case_sensitive: false

  # Used for searching organizations
  def self.search keyword
    where("name ilike :search or description ilike :search", search: "%#{keyword}%")
  end

end
