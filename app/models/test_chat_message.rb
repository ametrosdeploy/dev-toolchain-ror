# == Schema Information
#
# Table name: test_chat_messages
#
#  id           :bigint           not null, primary key
#  test_message :text
#  test_chat_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class TestChatMessage < ApplicationRecord
end
