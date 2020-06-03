# frozen_string_literal: true

# == Schema Information
#
# Table name: user_sections
#
#  id              :bigint           not null, primary key
#  user_id         :bigint           not null
#  section_id      :bigint           not null
#  time_started    :datetime
#  time_completed  :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  learn_mod_id    :integer
#  completed_count :integer          default(0)
#
class UserSection < ApplicationRecord
  belongs_to :user
  belongs_to :section
  belongs_to :learn_mod

  has_many :user_learn_objs

  validates_uniqueness_of :user_id, scope: %i[section_id]
  before_validation :set_learn_mod

  # This is just to skip multiple joins needed to find learn_mod_id of a user
  # Do not set this value from the form
  def set_learn_mod
    self.learn_mod_id = section.cutomer_learn_mod.learn_mod_id
  end
end
