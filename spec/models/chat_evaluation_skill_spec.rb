# == Schema Information
#
# Table name: chat_evaluation_skills
#
#  id                    :bigint           not null, primary key
#  skill_name            :string
#  skill_value           :integer
#  user_chat_response_id :bigint
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_chat_id          :bigint
#  user_chat_message_id  :bigint
#
require 'rails_helper'

RSpec.describe ChatEvaluationSkill, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
