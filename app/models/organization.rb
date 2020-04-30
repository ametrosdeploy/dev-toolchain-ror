class Organization < ApplicationRecord
  PER_PAGE = 10

  belongs_to :industry, autosave: true

  has_many :world_organizations
  has_many :worlds, through: :world_organizations

  has_many :organization_characters
  has_many :characters, through: :organization_characters

  accepts_nested_attributes_for :world_organizations
  accepts_nested_attributes_for :organization_characters

  has_one_attached :photo

  validates :name, :industry_id, presence: true

end
