# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_evaluations
#
#  id                     :bigint           not null, primary key
#  user_learn_obj_id      :bigint
#  quiz_submitted         :boolean          default(FALSE)
#  evaluated              :boolean          default(FALSE)
#  point_type             :integer
#  points                 :float
#  overall_assmnt_item_id :bigint
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  quiz_complete          :boolean          default(FALSE)
#  question_order_ids     :integer          default([]), is an Array
#  learning_object_id     :bigint
#
require 'rails_helper'

RSpec.describe QuizEvaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
