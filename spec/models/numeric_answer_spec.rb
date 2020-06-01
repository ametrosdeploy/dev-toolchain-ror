# frozen_string_literal: true

# == Schema Information
#
# Table name: numeric_answers
#
#  id               :bigint           not null, primary key
#  answer           :float
#  quiz_question_id :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe NumericAnswer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
