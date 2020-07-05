# frozen_string_literal: true

# == Schema Information
#
# Table name: nlu_entities
#
#  id                 :bigint           not null, primary key
#  learning_object_id :bigint           not null
#  entity             :string
#  entity_type        :string
#  score              :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class NluEntitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :entity, :entity_type, :score
end
