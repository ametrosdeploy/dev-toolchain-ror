# frozen_string_literal: true

# == Schema Information
#
# Table name: overall_assmnt_items
#
#  id                  :bigint           not null, primary key
#  min_score           :float
#  max_score           :float
#  feedback            :text
#  assessment_label_id :bigint           not null
#  learning_object_id  :bigint           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class OverallAssmntItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :min_score, :max_score, :feedback

  attribute :assessment_label do |assessment|
    assessment.assessment_label.name
  end

  attribute :learning_object do |assessment|
    assessment.learning_object.objectable
  end
end
