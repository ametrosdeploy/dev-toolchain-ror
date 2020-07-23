# == Schema Information
#
# Table name: test_chats
#
#  id                           :bigint           not null, primary key
#  assistant_session_id         :string
#  assistant_session_json       :jsonb
#  character_starts_interaction :boolean          default(FALSE), not null
#  user_id                      :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  chat_learn_obj_id            :integer
#
class TestChat < ApplicationRecord
    has_many    :test_chat_messages
    has_many    :test_chat_responses
end
