# == Schema Information
#
# Table name: user_chat_messages
#
#  id              :bigint           not null, primary key
#  learner_message :text
#  user_chat_id    :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  learner_id      :integer
#
class UserChatMessage < ApplicationRecord
    belongs_to  :user_chat
end
