# == Schema Information
#
# Table name: email_assessments
#
#  id                  :bigint           not null, primary key
#  email_skill_id      :integer
#  assessment_label_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'rails_helper'

RSpec.describe EmailAssessment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
