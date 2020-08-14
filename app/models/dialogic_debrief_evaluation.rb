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
#  dialogic_question_id   :bigint
#
class DialogicDebriefEvaluation < ApplicationRecord
  # Associations ...
  belongs_to :dialogic_evaluation
  belongs_to :dialogic_question
  belongs_to :key_topic
  belongs_to :assessment_label, optional: true
  has_many :dialogic_debrief_suggested_contents, dependent: :destroy
  has_many :adaptive_contents, through: :dialogic_debrief_suggested_contents

  # Validations ...
  validates_uniqueness_of :key_topic_id, scope: :dialogic_evaluation_id

  # Nested attributes ...
  accepts_nested_attributes_for :dialogic_debrief_suggested_contents,
                                allow_destroy: true
end
