# frozen_string_literal: true

# == Schema Information
#
# Table name: key_topics
#
#  id                   :bigint           not null, primary key
#  dialogic_question_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  asst_entity_id       :bigint           not null
#
class KeyTopicSerializer
  include FastJsonapi::ObjectSerializer

  attribute :asst_entities do |k|
    AsstEntitySerializer.new(k.asst_entity).as_json['data']
  end
end
