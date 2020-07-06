# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_evaluations
#
#  id                     :bigint           not null, primary key
#  user_learn_obj_id      :bigint           not null
#  overall_assmnt_item_id :bigint
#  overall_points         :float
#  repeat_count           :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  complete               :boolean          default(FALSE)
#
require 'rails_helper'

RSpec.describe DialogicEvaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
