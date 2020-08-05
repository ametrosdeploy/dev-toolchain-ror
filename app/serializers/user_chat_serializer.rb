# frozen_string_literal: true

# == Schema Information
#
# Table name: user_chats
#
#  id                           :bigint           not null, primary key
#  user_learn_obj_id            :integer
#  assistant_session_id         :string
#  assistant_session_json       :text
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  character_starts_interaction :boolean          default(FALSE), not null
#  overall_assmnt_item_id       :bigint
#  complete                     :boolean          default(FALSE), not null
#  skills_score_hash            :text
#  skills_missed                :text
#
class UserChatSerializer
    include FastJsonapi::ObjectSerializer
    attributes :user_learn_obj_id, :assistant_session_id, :assistant_session_json, :character_starts_interaction,:overall_assmnt_item_id, :complete, :skills_score_hash, :skills_missed

    attribute :chat_character
    attribute :mentor_character

    attribute :overall_assmnt_item do |evaluation|
        OverallAssmntItemSerializer.new(evaluation.overall_assmnt_item)
                                   .as_json['data']
    end

    attribute :chat_debrief_evaluations
end
