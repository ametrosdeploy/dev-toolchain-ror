# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_test_kt_evals
#
#  id                      :bigint           not null, primary key
#  dialogic_test_answer_id :bigint           not null
#  key_topic_id            :bigint           not null
#  dialogic_assmnt_item_id :bigint
#  missed_assmnt_item_id   :bigint
#  points_earned           :float
#  iteration_delivered     :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
require 'rails_helper'

RSpec.describe DialogicTestKtEval, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
