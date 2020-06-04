# frozen_string_literal: true

# == Schema Information
#
# Table name: slide_learn_objs
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  has_caption :boolean          default(TRUE)
#
class SlideLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :has_caption
  attribute :slider_images do |slide_learn_obj|
    SliderImageSerializer.new(slide_learn_obj.slider_images).as_json['data']
  end
end
