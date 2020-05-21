# frozen_string_literal: true

# == Schema Information
#
# Table name: video_learn_objs
#
#  id              :bigint           not null, primary key
#  global_video_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  title           :string
#  description     :text
#
require 'rails_helper'

RSpec.describe VideoLearnObj, type: :model do
end
