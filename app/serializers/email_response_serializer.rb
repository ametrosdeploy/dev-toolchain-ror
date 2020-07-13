# frozen_string_literal: true

# == Schema Information
#
# Table name: email_responses
#
#  id                 :bigint           not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  email_learn_obj_id :bigint           not null
#  character_id       :integer
#
class EmailResponseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attribute :character do |res|
    res.character
  end
  
  attribute :char_response_variations do |res|
    CharResponseVariationSerializer.new(res.char_response_variations)
                                   .as_json['data']
  end

  attribute :response_formulas do |res|
    ResponseFormulaSerializer.new(res.response_formulas)
                             .as_json['data']
  end
end
