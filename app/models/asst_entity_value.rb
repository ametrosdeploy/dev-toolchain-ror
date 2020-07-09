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
  # Associations ...
  belongs_to :asst_entity
  has_many :asst_entity_val_synonyms, dependent: :destroy

  # Nested attributes ...
  accepts_nested_attributes_for :asst_entity_val_synonyms, allow_destroy: true

  # Callbacks ...
  before_destroy :destroy_entity_value_from_watson

  # Methods...
  def format_value
    "@#{asst_entity.name}:(#{value})"
  end

  def destroy_entity_value_from_watson
    learn_obj = asst_entity.learning_object
    entity_hsh = { learning_object: learn_obj,
                   learn_mod: learn_obj.learn_mod,
                   entity_name: asst_entity.name }
    handler = AsstElementHandler::Entity.new(entity_hsh)
    handler.remove_entity_value(value)
  end
end
