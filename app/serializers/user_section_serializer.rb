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
class UserSectionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :section_id
end
