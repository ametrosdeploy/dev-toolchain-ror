# frozen_string_literal: true

# == Schema Information
#
# Table name: user_learn_mods
#
#  id             :bigint           not null, primary key
#  user_id        :bigint           not null
#  section_id     :bigint           not null
#  learn_mod_id   :bigint           not null
#  time_started   :datetime
#  time_completed :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class UserLearnMod < ApplicationRecord
  belongs_to :user
  belongs_to :section
  belongs_to :learn_mod
end
