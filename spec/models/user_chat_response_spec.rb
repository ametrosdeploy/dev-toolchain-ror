# == Schema Information
#
# Table name: user_chat_responses
#
#  id                               :bigint           not null, primary key
#  assistant_response               :text
#  mentor_character_id              :integer
#  chat_character_id                :integer
#  user_chat_id                     :integer
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  response_to_user_chat_message_id :integer
#
require 'rails_helper'

RSpec.describe UserChatResponse, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
