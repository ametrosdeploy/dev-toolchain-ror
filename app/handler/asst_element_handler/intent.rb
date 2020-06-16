# frozen_string_literal: true

module AsstElementHandler
  # Quiz Learn Object
  class Intent < AsstElementHandler::Base
    def initialize(args)
      super
      @intent = args[:intent]
      @name = args[:intent_name] || @intent&.name
    end

    def create_intent(examples = nil)
      response = @assistant_service.create_intent(@name, examples)
      return unless success?(response)

      intent_record = AsstIntent.create(learning_object: @learning_object,
                                        name: @name)
      eg_arr = examples&.map do |eg|
        { example: eg, asst_intent_id: intent_record.id,
          created_at: DateTime.now, updated_at: DateTime.now }
      end
      AsstIntentExample.insert_all(eg_arr) if eg_arr.present?
    end

    def remove_intent
      @assistant_service.delete_intent(@name)
    end
  end
end
