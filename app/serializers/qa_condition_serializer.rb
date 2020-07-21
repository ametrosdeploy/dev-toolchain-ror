# == Schema Information
#
# Table name: qa_conditions
#
#  id                 :bigint           not null, primary key
#  email_learn_obj_id :bigint           not null
#  character_id       :integer
#  ooto_response      :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class QaConditionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :ooto_response,

  attribute :char_response_variations do |res|
    CharResponseVariationSerializer.new(res.char_response_variations)
                                   .as_json['data']
  end
end
