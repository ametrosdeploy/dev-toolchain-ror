# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_tests
#
#  id                     :bigint           not null, primary key
#  dialogic_learn_obj_id  :bigint           not null
#  overall_assmnt_item_id :bigint           not null
#  overall_points         :float
#  user_id                :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe DialogicTest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
