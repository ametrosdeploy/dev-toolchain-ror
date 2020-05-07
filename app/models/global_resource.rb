class GlobalResource < ApplicationRecord
  PER_PAGE = 10
  acts_as_ordered_taggable

  enum resource_type: [:image, :document]

  belongs_to :customer

  has_many :world_global_resources
  has_many :worlds, through: :world_global_resources

  has_one_attached :attachment

  validates :customer_id, presence: true, if: :private?
  validates :title, presence: true

end
