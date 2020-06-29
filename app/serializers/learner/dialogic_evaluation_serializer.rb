# frozen_string_literal: true

class DialogicEvaluationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_learn_obj_id, :repeat_count
end
