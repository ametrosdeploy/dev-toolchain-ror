# == Schema Information
#
# Table name: assessment_formulas
#
#  id                       :bigint           not null, primary key
#  formula                  :string
#  email_assessment_item_id :integer
#  present_cond_keyword_min :integer
#  absent_cond_keyword_min  :integer
#  sentiment_enabled        :boolean          default(TRUE)
#  emotion_enabled          :boolean          default(TRUE)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
require 'rails_helper'

RSpec.describe AssessmentFormula, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
