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
class UserChat < ApplicationRecord
    belongs_to  :user_learn_obj
    belongs_to  :chat_learn_obj
    has_many    :user_chat_messages, dependent: :destroy
    has_many    :user_chat_responses, dependent: :destroy

    def chat_character
        WorldOrgCharacter.where(id: self.chat_learn_obj.chat_character_id).last
    end

    def mentor_character
        WorldOrgCharacter.where(id: self.chat_learn_obj.mentor_character_id).last
    end
end
