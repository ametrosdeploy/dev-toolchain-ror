# frozen_string_literal: true

# == Schema Information
#
# Table name: entity_evaluation_items
#
#  id                   :bigint           not null, primary key
#  entity_evaluation_id :bigint           not null
#  asst_entity_value_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class EntityEvaluationItem < ApplicationRecord
  # Associations ...
  belongs_to :entity_evaluation
  belongs_to :asst_entity_value
end
