class GlobalResource < ApplicationRecord
  PER_PAGE = 10
  acts_as_ordered_taggable

  belongs_to :customer
  enum resource_type: [:image, :document]

  has_one_attached :attachment

end
