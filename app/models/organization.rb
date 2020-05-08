class Organization < ApplicationRecord
  PER_PAGE = 10

  belongs_to :industry, autosave: true

  has_many :world_organizations, dependent: :destroy
  has_many :worlds, through: :world_organizations, dependent: :destroy

  has_many :organization_characters, dependent: :destroy
  has_many :characters, through: :organization_characters, dependent: :destroy

  accepts_nested_attributes_for :world_organizations
  accepts_nested_attributes_for :organization_characters
  accepts_nested_attributes_for :industry

  has_one_attached :photo

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false

  # Used for searching organizations
  def self.search keyword
    where("name ilike :search or description ilike :search", search: "%#{keyword}%")
  end

  # Assign exiting industry if it already exists
  def industry_attributes=(attributes)
    self.industry = Industry.find_or_create_by(name: attributes[:name])
  end

end
