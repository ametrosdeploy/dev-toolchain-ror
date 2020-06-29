# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_evaluations
#
#  id                     :bigint           not null, primary key
#  user_learn_obj_id      :bigint           not null
#  overall_assmnt_item_id :bigint
#  overall_points         :float
#  repeat_count           :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class DialogicEvaluation < ApplicationRecord
  belongs_to :user_learn_obj
  belongs_to :overall_assmnt_item, optional: true
end
