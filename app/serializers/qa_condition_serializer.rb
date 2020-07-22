# frozen_string_literal: true

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
  attributes :ooto_response

  attribute :character do |cond|
    WorldOrgCharacterTrimmedSerializer.new(cond.character)
                                      .as_json['data']
  end

  attribute :qa_formulas do |cond|
    QaFormulaSerializer.new(cond.qa_formulas)
                       .as_json['data']
  end
end
