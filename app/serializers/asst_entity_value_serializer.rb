# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_entity_values
#
#  id             :bigint           not null, primary key
#  value          :string
#  asst_entity_id :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  in_watson      :boolean          default(FALSE)
#
class AsstEntityValueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :value, :asst_entity_id

  attribute :asst_entity_val_synonyms do |entity_val|
    AsstEntityValSynonymSerializer.new(entity_val.asst_entity_val_synonyms).as_json['data']
  end
end
