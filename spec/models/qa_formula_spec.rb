# frozen_string_literal: true

# == Schema Information
#
# Table name: qa_formulas
#
#  id                       :bigint           not null, primary key
#  qa_condition_id          :bigint           not null
#  present_cond_keyword_min :integer
#  absent_cond_keyword_min  :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  sentiment_enabled        :boolean          default(TRUE)
#  emotion_enabled          :boolean          default(TRUE)
#
require 'rails_helper'

RSpec.describe QaFormula, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
