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
      @response = @assistant_service.create_intent(@name, examples)
    end

    def update_intent(args)
      hsh = {}
      hsh.merge!(new_intent: args[:name]) if args.key? :name
      hsh.merge!(new_description: args[:description]) if args.key? :description
      if args.key? :asst_intent_examples_attributes
        examples_attr = args[:asst_intent_examples_attributes]
        examples_to_add = process_list(examples_attr)
        hsh.merge!(new_examples: examples_to_add) if examples_to_add
      end
      @response = @assistant_service.update_intent(@intent.name, hsh)
    end

    def process_list(examples_attr)
      to_delete = examples_to_delete(examples_attr)
      to_add = examples_to_add(examples_attr)
      existing_examples = @intent.asst_intent_examples
                                      &.pluck(:example) || []
      to_add_examples = existing_examples + to_add - to_delete
      to_add_examples&.map { |e| { text: e } }
    end

    def examples_to_add(examples_attr)
      to_add = examples_attr.select { |hsh| hsh.key?(:example) }
      to_add&.pluck(:example)
    end

    def examples_to_delete(examples_attr)
      to_delete = examples_attr.select do |hsh|
        hsh.key?(:id) &&
          hsh.key?(:_destroy) &&
          hsh[:_destroy] == true
      end
      to_delete_ids = to_delete.pluck(:id)
      AsstIntentExample.where(id: to_delete_ids)&.pluck(:example)
    end

    def remove_intent
      @assistant_service.delete_intent(@name)
    end

    def sync_with_assistant
      @response = @assistant_service.list_intents
      unless success?
        errors(@response)
        nil
      end
      @result = @response.result
      save_intents_from_result
    rescue StandardError => e
      errors(e.message)
    end

    def save_intents_from_result
      intent_arr = @result['intents']
      intent_arr.each do |intent_info|
        intent = intent_info['intent']
        example_arr = intent_info['examples']
        examples = example_arr.pluck('text')
        AsstIntent.generate(intent, examples,
                            @learning_object.id)
      end
    end

    def add_examples(ex_list)
      hsh = { new_examples: ex_list }
      @response = @assistant_service.update_intent(@name, hsh)
    end
  end
end
