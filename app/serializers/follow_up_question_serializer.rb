# frozen_string_literal: true

class FollowUpQuestionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :question, :points
end
