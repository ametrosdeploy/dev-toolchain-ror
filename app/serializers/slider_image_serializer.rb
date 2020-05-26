# frozen_string_literal: true

class SliderImageSerializer
  include ImageHelper
  include FastJsonapi::ObjectSerializer
  attributes :caption

  attribute :resource_url do |file_learn_obj|
    image_url(file_learn_obj.global_resource.attachment)
  end
end
