# frozen_string_literal: true

# == Schema Information
#
# Table name: email_assessment_items
#
#  id                  :bigint           not null, primary key
#  email_skill_id      :integer
#  assessment_label_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  points              :integer
#
class EmailAssessmentItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email_skill_id, :points, :assessment_label_id,
             :assessment_label_name, :assessment_label_order


  attribute :debrief_contents do |item|
    DebriefSerializer.new(item.debriefs).as_json['data']
  end

  attribute :assessment_formulas do |assess|
    AssessmentFormulaSerializer.new(assess.assessment_formulas)
                             .as_json['data']
  end

  attribute :adaptive_contents do |item|
    AdaptiveContentSerializer.new(item.adaptive_contents).as_json['data']
  end
end
