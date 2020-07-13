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
#  in_watson          :boolean          default(FALSE)
#
class AsstEntity < ApplicationRecord
  # Associations ...
  belongs_to :learning_object
  has_many :asst_entity_values, dependent: :destroy
  # [when used for dialogic LO]
  has_many :key_topics, dependent: :destroy
  has_many :dialogic_questions, through: :key_topics

  # Nested Attributes ...
  accepts_nested_attributes_for :asst_entity_values, allow_destroy: true

  # validations ...
  validates_uniqueness_of :name, scope: :learning_object_id

  # Callbacks ...
  before_destroy :destroy_entity_from_watson

  def destroy_entity_from_watson
    learn_obj = learning_object
    entity_hsh = { learning_object: learn_obj,
                   learn_mod: learn_obj.learn_mod,
                   entity_name: name }
    handler = AsstElementHandler::Entity.new(entity_hsh)
    handler.remove_entity
  end

  # Methods ...
  def self.import(file_path, learning_object)
    CSV.foreach(file_path, headers: false) do |row|
      entity = row[0]
      entity = find_or_create_by(name: entity, learning_object_id: learning_object.id)
      args = { learning_object: learning_object,  entity: entity }
      entity_handler = AsstElementHandler::Entity.new(args)
      entity_handler.create_entity unless entity.in_watson
      entity.update(in_watson: true) if entity_handler.success?
      value_rec = entity.asst_entity_values.find_or_create_by(value: row[1])
      entity_handler.add_value_in_watson(value_rec.value) unless value_rec.in_watson
      value_rec.update(in_watson: true) if entity_handler.success?
      (2..(row.count - 1)).each do |synonym_index|
        synonym_rec = value_rec.asst_entity_val_synonyms.find_or_create_by(
          synonym: row[synonym_index]
        )
        entity_handler.add_synonym_in_watson(
          value_rec.value, synonym_rec.synonym) unless synonym_rec.in_watson
          synonym_rec.update(in_watson: true) if entity_handler.success?
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
