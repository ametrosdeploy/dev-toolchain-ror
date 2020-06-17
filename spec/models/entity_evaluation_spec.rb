# frozen_string_literal: true

# == Schema Information
#
# Table name: entity_evaluations
#
#  id               :bigint           not null, primary key
#  condition        :text
#  quiz_question_id :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe EntityEvaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
