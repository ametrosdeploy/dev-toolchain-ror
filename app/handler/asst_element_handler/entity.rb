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
      synonym_arr = synonyms.map do |s|
        { asst_entity_value_id: value.id, synonym: s,
          created_at: DateTime.now,
          updated_at: DateTime.now }
      end
      AsstEntityValSynonym.insert_all(synonym_arr)
      @entity
    end
  end
end
