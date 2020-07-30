# == Schema Information
#
# Table name: chat_evaluations
#
#  id                     :bigint           not null, primary key
#  user_learn_obj_id      :bigint
#  overall_assmnt_item_id :bigint
#  complete               :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class ChatEvaluation < ApplicationRecord
    belongs_to :user_learn_obj
    belongs_to :overall_assmnt_item, optional: true

    has_many    :chat_debrief_evaluations
end
