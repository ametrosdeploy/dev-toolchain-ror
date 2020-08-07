# == Schema Information
#
# Table name: user_chat_messages
#
#  id                               :bigint           not null, primary key
#  message                          :text
#  user_chat_id                     :integer
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  learner_id                       :integer
#  response_to_user_chat_message_id :integer
#  response_result_json             :json
#  assistant_response               :boolean          default(FALSE), not null
#  mentor_response                  :boolean          default(FALSE), not null
#
require 'rails_helper'

RSpec.describe UserChatMessage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
