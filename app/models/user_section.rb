# frozen_string_literal: true

# == Schema Information
#
# Table name: user_sections
#
#  id                  :bigint           not null, primary key
#  user_id             :bigint           not null
#  section_id          :bigint           not null
#  time_started        :datetime
#  time_completed      :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  learn_mod_id        :integer
#  completed_count     :integer          default(0)
#  status              :integer          default("active")
#  complete_percentage :integer          default(0)
#
class UserSection < ApplicationRecord
  belongs_to :user
  belongs_to :section
  belongs_to :learn_mod

  has_many :user_learn_objs

  enum status: %i[active completed expired]

  validates_uniqueness_of :user_id, scope: %i[section_id]
  before_validation :set_learn_mod

  after_save :build_user_learn_objects

  # This is just to skip multiple joins needed to find learn_mod_id of a user
  # Do not set this value from the form
  def set_learn_mod
    self.learn_mod_id = section.cutomer_learn_mod.learn_mod_id
  end

  def next_step
    user_learn_objs.incomplete.first
  end

  # incremented count by 1 as it also includes the current update count
  def comp_percentage
    ((completed_count + 1).to_f / user_learn_objs.size * 100).ceil
  end

  # Builds all the UserLearnObj data
  def build_user_learn_objects
    # We are considering that no additional LO will be created or published once
    # an ELM has been assigned to a user.
    return if user_learn_objs.present?

    learn_mod.learning_objects.published.each do |lo|
      learn_objs = user_learn_objs.build(learning_object_id: lo.id)
      learn_objs.save
      lo.card_type == 'dialogic' && learn_objs.build_dialogic_evaluation.save
    end
  end
end
