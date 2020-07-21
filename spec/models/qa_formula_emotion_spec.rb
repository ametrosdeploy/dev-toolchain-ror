# frozen_string_literal: true

# == Schema Information
#
# Table name: qa_formula_emotions
#
#  id            :bigint           not null, primary key
#  emotion       :integer
#  comparator    :integer
#  score         :float
#  qa_formula_id :bigint           not null
#  present_cond  :boolean          default(TRUE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe QaFormulaEmotion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
