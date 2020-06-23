# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_entities
#
#  id                 :bigint           not null, primary key
#  name               :string
#  learning_object_id :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class AsstEntity < ApplicationRecord
  # Associations ...
  belongs_to :learning_object
  has_many :asst_entity_values, dependent: :destroy

  # Nested Attributes ...
  accepts_nested_attributes_for :asst_entity_values, allow_destroy: true

  # validations ...
  validates_uniqueness_of :name, scope: :learning_object_id

  # Methods ...
  def self.import(file, obj_id)
    CSV.foreach(file.path, headers: false) do |row|
      entity = row[0]
      entity = find_or_create_by(name: entity, learning_object_id: obj_id)
      value = entity.asst_entity_values.find_or_create_by(value: row[1])
      (2..(row.count - 1)).each do |synonym_index|
        value.asst_entity_val_synonyms.find_or_create_by(
          synonym: row[synonym_index]
        )
      end
    end
  end

  def self.generate(entity, value, synonyms, obj_id)
    entity = find_or_create_by(name: entity, learning_object_id: obj_id)
    value = entity.asst_entity_values.find_or_create_by(value: value)
    synonyms.each do |synonym|
      value.asst_entity_val_synonyms.find_or_create_by(
        synonym: synonym
      )
    end
  end
end
