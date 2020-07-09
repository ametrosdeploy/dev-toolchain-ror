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
require 'rails_helper'

RSpec.describe UserChat, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
