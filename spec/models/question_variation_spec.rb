# frozen_string_literal: true

# == Schema Information
#
# Table name: question_variations
#
#  id                   :bigint           not null, primary key
#  question             :text
#  dialogic_question_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
require 'rails_helper'

RSpec.describe QuestionVariation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
