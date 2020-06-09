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
#
class AsstEntityValue < ApplicationRecord
  belongs_to :asst_entity
  has_many :asst_entity_val_synonyms

  accepts_nested_attributes_for :asst_entity_val_synonyms, allow_destroy: true

  def format_value
    "@#{asst_entity.name}:(#{value})"
  end
end
