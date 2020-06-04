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

  def update_completed_count
    user_section.update(completed_count: complete_lo_count)
  end

  def complete_lo_count
    user_section.user_learn_objs.active.count
  end
end
