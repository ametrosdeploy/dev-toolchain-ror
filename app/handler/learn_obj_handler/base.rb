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
    end

    # Returns learning object JSON data
    def response
      LearningObjectSerializer.new(learning_object).serializable_hash
    end

    def save_record
      build_record && valid_record && learning_object.save
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
  end
end
