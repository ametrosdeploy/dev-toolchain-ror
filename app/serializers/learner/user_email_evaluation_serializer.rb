# frozen_string_literal: true

module Learner
  class UserEmailEvaluationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :email_subject, :qa_condition_hit, :overall_score, :has_max_score


    attribute :overall_assmnt_item, if: proc { |record|
          record.user_email_iterations.last&.overall_assmnt_item_id?
        } do |eval|
          OverallAssmntItemSerializer.new(eval.overall_assmnt_item)
            .as_json['data']
    end

    # attribute :user_email_iterations do |rec|
    #   UserEmailIterationSerializer.new(rec.user_email_iterations).as_json['data']
    # end

    attribute :learner_debrief_items do |rec|
      Learner::UserEmailAssessmentItemSerializer.new(rec.learner_debrief_items).as_json['data']
    end 

    
    attribute :iteration do |rec|
      rec.user_email_iterations.length
    end
    
  end
end
