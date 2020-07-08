# == Schema Information
#
# Table name: user_chat_messages
#
#  id                 :bigint           not null, primary key
#  learner_message    :text
#  assistant_response :text
#  mentor             :boolean          default(FALSE), not null
#  user_chat_id       :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class UserChatMessage < ApplicationRecord
    belongs_to  :user_chat
end
