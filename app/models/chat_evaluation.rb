# == Schema Information
#
# Table name: chat_evaluations
#
#  id                     :bigint           not null, primary key
#  overall_assmnt_item_id :bigint
#  complete               :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_chat_id           :bigint
#
class ChatEvaluation < ApplicationRecord
    belongs_to :user_chat
    belongs_to :overall_assmnt_item, optional: true

    has_many    :chat_debrief_evaluations
    has_many    :chat_evaluation_skills
end
