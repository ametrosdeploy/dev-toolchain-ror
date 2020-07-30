# frozen_string_literal: true

class DialogicTestSerializer
  include FastJsonapi::ObjectSerializer
  attributes :dialogic_learn_obj_id, :user_id,
             :overall_assmnt_item_id, :overall_points
end
