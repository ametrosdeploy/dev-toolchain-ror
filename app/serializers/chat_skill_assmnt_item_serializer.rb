# frozen_string_literal: true

# == Schema Information
#
# Table name: chat_skill_assmnt_items
#
#  id                  :bigint           not null, primary key
#  assessment_label_id :integer
#  value_count_min     :integer
#  value_count_max     :integer
#  points              :float
#  chat_skill_id       :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ChatSkillAssmntItemSerializer
    include FastJsonapi::ObjectSerializer
    attributes :assessment_label_id, :value_count_min, :value_count_max, :points, :chat_skill_id
end
  