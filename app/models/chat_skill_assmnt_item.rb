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
class ChatSkillAssmntItem < ApplicationRecord
    belongs_to  :assessment_label
    belongs_to  :chat_skill
    has_many :debriefs, as: :debriefable

    accepts_nested_attributes_for :debriefs, allow_destroy: true
end
