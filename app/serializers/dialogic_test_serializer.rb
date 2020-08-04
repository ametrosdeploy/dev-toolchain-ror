# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_tests
#
#  id                     :bigint           not null, primary key
#  dialogic_learn_obj_id  :bigint           not null
#  overall_assmnt_item_id :bigint
#  overall_points         :float
#  user_id                :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
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
