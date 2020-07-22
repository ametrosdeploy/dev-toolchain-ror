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
require 'rails_helper'

RSpec.describe UserChatMessage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
