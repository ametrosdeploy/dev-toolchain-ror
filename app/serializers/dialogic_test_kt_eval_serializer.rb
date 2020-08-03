# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_test_kt_evals
#
#  id                      :bigint           not null, primary key
#  dialogic_test_answer_id :bigint           not null
#  key_topic_id            :bigint           not null
#  dialogic_assmnt_item_id :bigint
#  missed_assmnt_item_id   :bigint
#  points_earned           :float
#  iteration_delivered     :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class DialogicTestKtEvalSerializer
  include FastJsonapi::ObjectSerializer
  attributes :key_topic_id, :points_earned

  attribute :dialogic_assmnt_item, if: proc { |record|
                                         record.dialogic_assmnt_item_id?
                                       } do |eval|
    DialogicAssmntItemSerializer.new(eval.dialogic_assmnt_item)
                                .as_json['data']
  end

  attribute :missed_assmnt_item_id, if: proc { |record|
                                          record.missed_assmnt_item_id?
                                        } do |eval|
    MissedAssmntItemSerializer.new(eval.missed_assmnt_item).as_json['data']
  end
end
