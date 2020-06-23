# frozen_string_literal: true

# == Schema Information
#
# Table name: user_learn_objs
#
#  id                 :bigint           not null, primary key
#  user_section_id    :bigint           not null
#  complete           :boolean          default(FALSE)
#  learning_object_id :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class UserLearnObj < ApplicationRecord
  belongs_to :user_section
  belongs_to :learning_object

  after_save :update_completed_count, if: :saved_change_to_complete?
  after_destroy :update_completed_count

  scope :with_active, -> { where(complete: true) }
  scope :incomplete, -> { where(complete: false) }

  # Updates completed_count & start,end time on user_section
  def update_completed_count
    pct = user_section.comp_percentage
    comp_json = { completed_count: complete_lo_count, complete_percentage: pct }
    comp_json.merge!(time_started: Time.current) if complete_lo_count == 1
    comp_json.merge!(completed_hash) if last_completed
    user_section.update(comp_json)
  end

  def complete_lo_count
    user_section.user_learn_objs.with_active.count
  end

  def completed_hash
    {
      time_completed: Time.current,
      status: UserSection.statuses[:completed]
    }
  end

  # Only first incomplete card can be completed
  def valid_step?
    next_step = user_section.next_step
    (next_step && id <= next_step.id) || user_section.completed?
  end

  # Checks if LO to be completed is last one
  def last_completed
    user_section.completed_count == (user_section.user_learn_objs.count - 1)
  end
end
