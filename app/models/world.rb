class World < ApplicationRecord
  PER_PAGE = 10

  belongs_to :customer, optional: true

  has_many :world_organizations
  has_many :organizations, through: :world_organizations

  validates :name, presence: true
  validates :customer_id, presence: true, if: :is_private?
  # validates :customer_id, numericality: { only_integer: true }

  accepts_nested_attributes_for :world_organizations

  before_create :set_uniq_token

  private

  # set unique world code to the world
  def set_uniq_token
    self.world_code = (1..9).sort_by { rand }.join.to_i
    set_uniq_token if World.exists?(world_code: world_code)
  end
end
