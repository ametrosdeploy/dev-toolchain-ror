# == Schema Information
#
# Table name: test_chat_messages
#
#  id                               :bigint           not null, primary key
#  message                          :text
#  test_chat_id                     :integer
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  mentor_character_id              :integer
#  chat_character_id                :integer
#  response_to_test_chat_message_id :integer
#  response_result_json             :json
#  assistant_response               :boolean          default(FALSE), not null
#
require 'rails_helper'

RSpec.describe TestChatMessage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
