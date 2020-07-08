# frozen_string_literal: true

# == Schema Information
#
# Table name: chat_skill_assmnt_misseds
#
#  id            :bigint           not null, primary key
#  chat_skill_id :integer
#  points        :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ChatSkillAssmntMissedSerializer
    include FastJsonapi::ObjectSerializer
    attributes :points, :chat_skill_id
end
  