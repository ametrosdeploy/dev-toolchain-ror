# frozen_string_literal: true

# == Schema Information
#
# Table name: chat_evaluations
#
#  id                     :bigint           not null, primary key
#  overall_assmnt_item_id :bigint
#  complete               :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_chat_id           :bigint
#

module Learner
  class ChatEvaluationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :user_chat_id, :overall_assmnt_item_id, :complete, :skills_score_hash, :skills_missed
  
    attribute :overall_assmnt_item do |evaluation|
      OverallAssmntItemSerializer.new(evaluation.overall_assmnt_item)
                                 .as_json['data']
    end

  end
end
  