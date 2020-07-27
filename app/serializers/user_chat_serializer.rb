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
#  chat_learn_obj_id            :integer
#
class UserChatSerializer
    include FastJsonapi::ObjectSerializer
    attributes :user_learn_obj_id, :assistant_session_id, :assistant_session_json, :character_starts_interaction, :chat_learn_obj_id

    attribute :chat_character 
    attribute :mentor_character
end
  
