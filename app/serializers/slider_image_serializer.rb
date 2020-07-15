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
  include FastJsonapi::ObjectSerializer
  attributes :caption, :global_resource_id

  attribute :resource_url do |file_learn_obj|
    file_learn_obj.global_resource.attachement_variations
  end
end
