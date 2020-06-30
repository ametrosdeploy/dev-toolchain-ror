# frozen_string_literal: true

module Learner
  class DialogicEvaluationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :user_learn_obj_id, :repeat_count
  end
end
