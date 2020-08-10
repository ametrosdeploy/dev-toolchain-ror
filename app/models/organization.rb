# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  description      :text
#  real_world       :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  characters_count :integer          default(0)
#  industry_id      :bigint           not null
#
class Organization < ApplicationRecord
  PER_PAGE = 10
  strip_attributes

  belongs_to :industry, autosave: true

  has_many :world_organizations, dependent: :destroy
  has_many :worlds, through: :world_organizations, dependent: :destroy

  has_many :organization_characters, dependent: :destroy
  has_many :characters, through: :organization_characters, dependent: :destroy

  accepts_nested_attributes_for :world_organizations, allow_destroy: true
  accepts_nested_attributes_for :organization_characters, allow_destroy: true
  accepts_nested_attributes_for :industry

  has_one_attached :photo

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false

  # Used for searching organizations
  def self.search(keyword)
    where('organizations.name ilike :search or description ilike :search or
      industries.name ilike :search', search: "%#{keyword}%")
  end

  # Assign exiting industry if it already exists
  def industry_attributes=(attributes)
    self.industry = Industry.find_or_create_by(name: attributes[:name])
  end

  def attachement_variations
    return false unless photo.attached?

    {
      thumbnail: photo.variant({ resize: '124X124' }).processed.service_url
    }
  rescue ActiveStorage::FileNotFoundError, ActiveStorage::InvariableError
    false
  end
end
