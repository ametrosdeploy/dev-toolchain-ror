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
require 'rails_helper'

RSpec.describe SliderImage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
