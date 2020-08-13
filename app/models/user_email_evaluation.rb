# frozen_string_literal: true

# == Schema Information
#
# Table name: user_email_evaluations
#
#  id                     :bigint           not null, primary key
#  keyword_list           :string           default([]), is an Array
#  concept_list           :string           default([]), is an Array
#  nlu_entities_list      :string           default([]), is an Array
#  joy_score              :float
#  anger_score            :float
#  disgust_score          :float
#  sadness_score          :float
#  fear_score             :float
#  asst_intent_list       :string           default([]), is an Array
#  asst_entity_value_list :integer          default([]), is an Array
#  sentiment              :string
#  sentiment_score        :float
#  user_learn_obj_id      :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  overall_score          :float
#  qa_condition_hit       :boolean          default(FALSE), not null
#
class UserEmailEvaluation < ApplicationRecord
  # Associations ...
  belongs_to :user_learn_obj
  has_many :user_email_iterations, dependent: :destroy
  has_many :response_formula_hits, dependent: :destroy
  has_many :assessment_formula_hits, dependent: :destroy
  has_many :user_email_assessment_items, dependent: :destroy

  # Nested attributes ...
  accepts_nested_attributes_for :user_email_iterations, allow_destroy: true

  # Methods...

  def highest_possible_score
    email_skills = EmailSkill.where(email_learn_obj_id: self.user_learn_obj.learning_object.objectable.id).pluck(:id)
    highest_assessments_total_points = EmailAssessmentItem.where(email_skill_id: email_skills).joins(:assessment_label).where(:assessment_labels => {order: 1 }).pluck(:points).sum
  end

  def learning_object
    user_learn_obj.learning_object
  end

  # Checks if new email iteration can be saved
  def valid_iteration?
    (it_enabled? && it_count <= email_lo.iteration_level) || it_count == 1
  end

  def email_lo
    user_learn_obj.learning_object.objectable
  end

  def it_count
    user_email_iterations.size
  end

  def it_enabled?
    email_lo.iteration_enabled?
  end

  def complete?
    (it_enabled? && ( reached_limit? || has_max_score?)) || it_count == 1
  end

  def reached_limit?
    it_count == email_lo.iteration_level
  end

  def overall_assmnt_item
    user_email_iterations.last&.overall_assmnt_item
  end

  def mark_has_max_score
    self.update(has_max_score: true)
  end

  def overall_assmnt_item
    user_email_iterations.last&.overall_assmnt_item
  end
end
