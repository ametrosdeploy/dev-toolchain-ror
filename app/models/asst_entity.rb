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
    return unless in_watson

    learn_obj = learning_object
    entity_hsh = { learning_object: learn_obj,
                   learn_mod: learn_obj.learn_mod,
                   entity_name: name }
    handler = AsstElementHandler::Entity.new(entity_hsh)
    handler.remove_entity
  end

  # Methods ...
  def self.import(file, learning_object)
    entity_list = []
    CSV.foreach(file.path, headers: false) do |row|
      entity_name = row[0]
      entity = find_or_create_by(name: entity_name,
                                 learning_object_id: learning_object.id)
      entity_list << entity
      value_rec = entity.asst_entity_values.find_or_create_by(value: row[1])
      save_synonyms_from_csv(row, value_rec)
    end
    add_entities_to_watson(entity_list)
  end

  def self.save_synonyms_from_csv(row, value_rec)
    (2..(row.count - 1)).each do |synonym_index|
      value_rec.asst_entity_val_synonyms.find_or_create_by(
        synonym: row[synonym_index]
      )
    end
  end

  def self.add_entities_to_watson(entity_list)
    entity_list.uniq!
    entity_list.each do |entity_rec|
      entity_handler = entity_rec.entity_handler_obj
      entity_rec.add_to_watson(entity_handler)
    end
  end

  def add_to_watson(handler)
    unless in_watson
      handler.create_entity
      update(in_watson: true) if handler.success?
    end
    values = asst_entity_values.where(in_watson: false)
    values.each do |value|
      handler.add_value_and_synonym_in_watson(value)
    end
    return unless handler.success?

    mark_values_as_added_to_watson(values)
  end

  def mark_values_as_added_to_watson(values = nil)
    values ||= asst_entity_values.where(in_watson: false)
    values.update_all(in_watson: true)
    value_ids = values.pluck(:id)
    synonyms = AsstEntityValSynonym.where(asst_entity_value_id: value_ids,
                                          in_watson: false)
    synonyms.update_all(in_watson: true)
  end

  def entity_handler_obj
    args = { learning_object: learning_object,
             learn_mod: learning_object.learn_mod,
             entity: self }
    AsstElementHandler::Entity.new(args)
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
