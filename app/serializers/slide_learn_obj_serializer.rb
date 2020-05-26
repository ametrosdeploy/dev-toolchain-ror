# frozen_string_literal: true

# Slide Learn Object serializer
class SlideLearnObjSerializer
  include FastJsonapi::ObjectSerializer

  attribute :slider_images do |slide_learn_obj|
    SliderImageSerializer.new(slide_learn_obj.slider_images).as_json['data']
  end
end
