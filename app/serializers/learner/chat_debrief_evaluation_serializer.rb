# frozen_string_literal: true

# == Schema Information
#
# Table name: chat_debrief_evaluations
#
#  id                          :bigint           not null, primary key
#  chat_evaluation_id          :bigint
#  assessment_label_id         :bigint
#  chat_skill_assmnt_item_id   :bigint
#  chat_skill_assmnt_missed_id :bigint
#  debrief_received            :text
#  assmnt_item_points          :float
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

module Learner
  class ChatDebriefEvaluationSerializer
    include FastJsonapi::ObjectSerializer
    include ImageHelper
    attributes :user_chat_id, :assessment_label_id, :chat_skill_assmnt_item_id,
               :chat_skill_assmnt_missed_id, :debrief_received,
               :assmnt_item_points

    attribute :assessment_label do |assessment|
      assessment.assessment_label.try(:name)
    end

    attribute :assessment_icon_url do |assessment|
      image_url(assessment.assessment_label.try(:icon))
    end

    attribute :chat_skill_assmnt_item do |assessment_item|
      assmnt_item = assessment_item.chat_skill_assmnt_item
      Learner::ChatSkillAssmntItemSerializer.new(assmnt_item).as_json['data']
    end

    attribute :chat_skill_assmnt_missed do |assessment_item|
      assmnt_item = assessment_item.chat_skill_assmnt_missed
      Learner::ChatSkillAssmntMissedSerializer.new(assmnt_item).as_json['data']
    end
  end
end
