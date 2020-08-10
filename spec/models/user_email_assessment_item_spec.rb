# == Schema Information
#
# Table name: user_email_assessment_items
#
#  id                       :bigint           not null, primary key
#  email_assessment_item_id :bigint
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
require 'rails_helper'

RSpec.describe UserEmailAssessmentItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
