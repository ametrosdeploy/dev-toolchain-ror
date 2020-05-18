# frozen_string_literal: true

# == Schema Information
#
# Table name: worlds
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  description      :text
#  world_code       :integer          not null
#  is_private       :boolean
#  learn_mods_count :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  customer_id      :integer
#
class World < ApplicationRecord
  PER_PAGE = 10
  strip_attributes

  belongs_to :customer, optional: true

  has_many :world_organizations, dependent: :destroy
  has_many :organizations, through: :world_organizations
  has_many :learn_mods

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false
  validates :customer_id, presence: true, if: :is_private?
  # validates :customer_id, numericality: { only_integer: true }

  accepts_nested_attributes_for :world_organizations, allow_destroy: true

  before_create :set_uniq_token

  # Used for searching worlds
  def self.search(keyword)
    where('name ilike :lsearch or world_code = :search or description ilike :lsearch',
          search: keyword.delete('^0-9').to_i, lsearch: "%#{keyword}%")
  end

  private

  # set unique world code to the world
  def set_uniq_token
    self.world_code = (1..9).sort_by { rand }.join.to_i
    set_uniq_token if World.exists?(world_code: world_code)
  end
end
