# == Schema Information
#
# Table name: chat_debrief_evaluations
#
#  id                          :bigint           not null, primary key
#  chat_evaluation_id          :bigint
#  assessment_label_id         :bigint
#  chat_skill_assmnt_item_id   :bigint
#  chat_skill_assmnt_missed_id :bigint
#  debrief_received            :text
#  assmnt_item_points          :float
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#
class ChatDebriefEvaluation < ApplicationRecord
    belongs_to  :chat_evaluation
    belongs_to  :assessment_label, optional: true 
    belongs_to  :chat_skill_assmnt_item, optional: true 
    belongs_to  :chat_skill_assmnt_missed, optional: true

end
