# frozen_string_literal: true

module AsstElementHandler
  # Entity/value/synonym creation in both Watson...
  class Entity < AsstElementHandler::Base
    attr_reader :response
    def initialize(args)
      super
      @entity = args[:entity]
      @name = args[:entity_name] || @entity&.name
      @result = nil
    end

    def sync_with_assistant
      @response = @assistant_service.list_entities
      unless success?
        errors(@response)
        nil
      end
      @result = @response.result
      save_entity_from_result
    rescue StandardError => e
      errors(e.message)
    end

    def save_entity_from_result
      entity_arr = @result['entities']
      entity_arr.each do |entity_info|
        entity = entity_info['entity']
        value_arr = entity_info['values']
        value_arr.each do |value_info|
          value = value_info['value']
          synonym_arr = value_info['synonyms']
          AsstEntity.generate(entity, value, synonym_arr,
                              @learning_object.id)
        end
      end
    end

    def create_entity
      @response = @assistant_service.create_entity(@name)
      unless success?
        errors(@response)
        nil
      end
    rescue StandardError => e
      errors(e.message)
    end

    def add_value_and_synonym_in_watson(value_record)
      value = value_record.value
      synonyms = value_record.asst_entity_val_synonyms&.map { |s| s.synonym }
      @response = @assistant_service.create_entity_value(@name, value, synonyms)
    rescue StandardError => e
      errors(e.message)
    end

    def update_value_and_synonym_in_watson(value_record, value_param)
      value = value_record.value
      new_value = value_param[:value]
      synonyms_attr = value_param[:asst_entity_val_synonyms_attributes]
      if synonyms_attr
        synonym_list = updated_synonym_list(value_record, synonyms_attr)
      end
      @response = @assistant_service
                  .update_entity_value(@name, value, new_value, synonym_list)
    rescue StandardError => e
      errors(e.message)
    end

    def updated_synonym_list(value_record, synonyms_attr)
      to_delete = synonyms_to_delete(synonyms_attr)
      to_add = synonyms_to_add(synonyms_attr)
      existing_synonyms = value_record.asst_entity_val_synonyms
                                      .pluck(:synonym)
      existing_synonyms + to_add - to_delete
    end

    def synonyms_to_add(synonyms_attr)
      to_add = synonyms_attr.select { |hsh| hsh.key?(:synonym) }
      to_add&.pluck(:synonym)
    end

    def synonyms_to_delete(synonyms_attr)
      to_delete = synonyms_attr.select do |hsh|
        hsh.key?(:id) &&
          hsh.key?(:_destroy) &&
          hsh[:_destroy] == true
      end
      to_delete_ids = to_delete.pluck(:id)
      AsstEntityValSynonym.where(id: to_delete_ids)&.pluck(:synonym)
    end
  end
end
