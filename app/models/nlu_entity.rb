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
class NluEntity < ApplicationRecord
  # Associations ...
  belongs_to :learning_object
  has_many :response_formula_items, as: :enrichment_item
end
