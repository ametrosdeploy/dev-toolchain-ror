# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_debrief_evaluations
#
#  id                     :bigint           not null, primary key
#  dialogic_evaluation_id :bigint           not null
#  key_topic_id           :bigint           not null
#  assessment_label_id    :integer
#  debrief_received       :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  key_topic_missed       :boolean          default(FALSE)
#  kt_points              :float
#
class DialogicDebriefEvaluation < ApplicationRecord
  belongs_to :dialogic_evaluation
  belongs_to :key_topic
  belongs_to :assessment_label, optional: true

  # Validations ...
  validates_uniqueness_of :key_topic_id, scope: :dialogic_evaluation_id
end
