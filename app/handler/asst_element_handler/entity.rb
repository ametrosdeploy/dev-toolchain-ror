# frozen_string_literal: true

module AsstElementHandler
  # Quiz Learn Object
  class Entity < AsstElementHandler::Base
    def initialize(args)
      super
      @entity = args[:entity]
      @name = args[:entity_name] || @entity&.name
    end

    def create_entity
      response = @assistant_service.create_entity(@name)
      return unless success?(response)

      AsstEntity.create(learning_object: @learning_object,
                        name: @name)
    end

    def create_entity_val_and_synonyms(val, synonyms)
      response = @assistant_service.create_entity_value(@name, val, synonyms)
      return unless success?(response)

      value = @entity.asst_entity_values.create(value: val)
      add_synonym_records(value, synonyms)
      @entity
    end

    def update_val_and_synonyms(val, new_val, synonyms = nil)
      return unless value_update_required?(val, new_val, synonyms)

      response = @assistant_service
                 .update_entity_value(@name, val, new_val, synonyms)
      return unless success?(response)

      value_record = @entity.asst_entity_values.find_by(value: val)
      value_record&.update(value: new_val) if val != new_val
      if synonyms.present?
        value_record.asst_entity_val_synonyms.destroy_all
        add_synonym_records(value_record, synonyms)
      end
      @entity
    end

    def add_synonym_records(value, synonyms)
      synonym_arr = synonyms.map do |s|
        { asst_entity_value_id: value.id, synonym: s,
          created_at: DateTime.now,
          updated_at: DateTime.now }
      end
      AsstEntityValSynonym.insert_all(synonym_arr)
    end

    def value_update_required?(val, new_val, synonyms)
      (val != new_val) || synonyms.present?
    end
  end
end
