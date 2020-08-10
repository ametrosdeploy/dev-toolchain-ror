# frozen_string_literal: true

# == Schema Information
#
# Table name: response_formulas
#
#  id                       :bigint           not null, primary key
#  formula                  :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  email_response_id        :bigint           not null
#  present_cond_keyword_min :integer          default(0)
#  absent_cond_keyword_min  :integer          default(0)
#  sentiment_enabled        :boolean          default(TRUE)
#  emotion_enabled          :boolean          default(TRUE)
#
require 'rails_helper'

RSpec.describe ResponseFormula, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
