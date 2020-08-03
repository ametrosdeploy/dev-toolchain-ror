# frozen_string_literal: true

# Dialogic Test Serializer ...
class DialogicTestSerializer
  include FastJsonapi::ObjectSerializer
  attributes :dialogic_learn_obj_id, :user_id,
             :overall_assmnt_item_id, :overall_points

  attribute :dialogic_debrief_evaluations do |question|
    DialogicTestDebriefSerializer.new(
      question.dialogic_debrief_evaluations
    ).as_json['data']
  end
end
