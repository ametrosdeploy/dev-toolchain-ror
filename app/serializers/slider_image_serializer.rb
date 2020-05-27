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
class SliderImageSerializer
  include ImageHelper
  include FastJsonapi::ObjectSerializer
  attributes :caption

  attribute :resource_url do |file_learn_obj|
    image_url(file_learn_obj.global_resource.attachment)
  end
end
