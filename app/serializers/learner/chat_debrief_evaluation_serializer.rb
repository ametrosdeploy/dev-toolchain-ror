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
      attributes :chat_evaluation_id, :assessment_label_id, :chat_skill_assmnt_item_id, :chat_skill_assmnt_missed_id, :debrief_received, :assmnt_item_points
    
      
  
    end
  end
    