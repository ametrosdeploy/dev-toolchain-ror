# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_intents
#
#  id                 :bigint           not null, primary key
#  name               :string
#  description        :text
#  learning_object_id :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class AsstIntentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description

  attribute :asst_intent_examples do |intent|
    AsstIntentExampleSerializer.new(intent.asst_intent_examples).as_json['data']
  end
end
