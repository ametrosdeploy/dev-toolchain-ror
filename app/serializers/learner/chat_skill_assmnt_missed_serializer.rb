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

module Learner
  # ChatSkillAssmntMissed Serializer...
  class ChatSkillAssmntMissedSerializer
    include FastJsonapi::ObjectSerializer
    attributes :points, :chat_skill_id

    attribute :debrief_contents do |item|
      DebriefSerializer.new(item.debriefs).as_json['data']
    end

    attribute :adaptive_contents do |item|
      AdaptiveContentSerializer.new(item.adaptive_contents).as_json['data']
    end
  end
end
