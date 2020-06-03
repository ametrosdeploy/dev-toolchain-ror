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
require 'rails_helper'

RSpec.describe SlideLearnObj, type: :model do
end
