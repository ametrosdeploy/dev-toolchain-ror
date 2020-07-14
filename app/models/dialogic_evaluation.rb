# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_evaluations
#
#  id                     :bigint           not null, primary key
#  user_learn_obj_id      :bigint           not null
#  overall_assmnt_item_id :bigint
#  overall_points         :float
#  repeat_count           :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  complete               :boolean          default(FALSE)
#  used_variation_ids     :integer          default([]), is an Array
#  variation_order_ids    :integer          default([]), is an Array
#
class DialogicEvaluation < ApplicationRecord
  belongs_to :user_learn_obj
  belongs_to :overall_assmnt_item, optional: true
  has_many :dialogic_answers, dependent: :destroy
  has_many :dialogic_debrief_evaluations, dependent: :destroy

  scope :latest, -> { order('id desc') }

  # Call this to complete a dialogic
  def complete_dialogic
    update(complete: true)
  end

  def complete?
    dialogic_debrief_evaluations
  end

  # Gives Quiz in Random order & Also preserves the order
  def variation_ids(dilogic_learn_obj_id)
    if variation_order_ids?
      variation_order_ids
    else
      new_variation_set(dilogic_learn_obj_id)
    end
  end

  def variations_list(dilogic_learn_obj_id)
    QuestionVariation.find(variation_ids(dilogic_learn_obj_id))
  end

  def new_variation_set(dilogic_learn_obj_id)
    vars = variations(dilogic_learn_obj_id)
    ques_ids = []
    vars.each do |_key, val|
      ques_ids << random_ids(val)
    end
    new_list = (used_variation_ids + ques_ids).uniq
    update(variation_order_ids: ques_ids)
    user_learn_obj.update(used_variation_ids: new_list)
    ques_ids
  end

  # ReturnsVariations list grouped by questions
  def variations(obj_id)
    QuestionVariation.joins(:dialogic_question)
                     .where('dialogic_questions.dialogic_learn_obj_id': obj_id)
                     .order('dialogic_questions.order asc')
                     .group_by(&:dialogic_question_id)
  end

  def random_ids(val)
    selected = nil
    3.times do
      random_id = val.map(&:id).sample
      selected = random_id unless used_variation_ids.include?(random_id)
    end
    selected ||= val.map(&:id).sample
  end

  def used_variation_ids
    user_learn_obj.used_variation_ids
  end
end
