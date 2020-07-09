# frozen_string_literal: true

# == Schema Information
#
# Table name: user_chats
#
#  id                           :bigint           not null, primary key
#  user_learn_obj_id            :integer
#  assistant_sessionid          :string
#  assistant_session_json       :text
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  character_starts_interaction :boolean          default(FALSE), not null
#
class UserChatSerializer
    include FastJsonapi::ObjectSerializer
    attributes :user_learn_obj_id, :assistant_sessionid, :assistant_session_json, :character_starts_interaction
end
  
