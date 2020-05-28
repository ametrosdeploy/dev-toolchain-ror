# frozen_string_literal: true

# == Schema Information
#
# Table name: slider_images
#
#  id                 :bigint           not null, primary key
#  caption            :string
#  slide_learn_obj_id :bigint           not null
#  global_resource_id :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class SliderImage < ApplicationRecord
  belongs_to :slide_learn_obj
  belongs_to :global_resource

  validate :global_resource_type

  def global_resource_type
    return unless global_resource

    errors.add(:global_resource_id, 'Please select/upload image.') unless
      global_resource.image?
  end
end
