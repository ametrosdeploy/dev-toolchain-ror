# frozen_string_literal: true

module LearnObjHandler
  class Base
    # ComponentMissing = Class.new(StandardError)
    attr_reader :learn_mod, :params, :learning_object_params, :learning_object

    def initialize(args)
      @params     = args[:params]
      @learn_mod  = args[:learn_mod]
      @learning_object_params = args[:learning_object_params]
      @learning_object = args[:learning_object]
      set_lo_order if @learning_object.new_record?
    end

    # Returns learning object JSON data
    def response
      LearningObjectSerializer.new(learning_object).serializable_hash
    end

    def save_record
      set_lo_params && build_record
      @learning_object.save if valid_record
    end

    def valid_record
      learning_object.objectable.valid? && learning_object.valid?
    end

    def errors
      if !learning_object.valid?
        learning_object.errors
      else
        learning_object.objectable.errors
      end
    end

    def has_card?
      params[:card]
    end

    # Returns new LO order number
    def get_lo_order
      learn_mod.learning_objects.count + 1
    end

    # Sets LO order on create
    def set_lo_order
      @learning_object_params.merge!({ card_order: get_lo_order })
    end

    def set_lo_params
      @learning_object.attributes = learning_object_params
    end

  end
end
