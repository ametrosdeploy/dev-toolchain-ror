# frozen_string_literal: true

# == Schema Information
#
# Table name: slide_learn_objs
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Slide Learn Object serializer
class SlideLearnObjSerializer
  include FastJsonapi::ObjectSerializer

  attribute :slider_images do |slide_learn_obj|
    SliderImageSerializer.new(slide_learn_obj.slider_images).as_json['data']
  end
end
