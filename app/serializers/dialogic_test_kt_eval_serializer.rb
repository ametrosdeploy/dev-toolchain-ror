# frozen_string_literal: true

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
