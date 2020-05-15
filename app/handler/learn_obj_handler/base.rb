module LearnObjHandler
  class Base
    ComponentMissing = Class.new(StandardError)
    attr_reader :learn_mod, :params, :learning_object_params

    def initialize(args)
      @params     = args[:params]
      @learn_mod  = args[:learn_mod]
      @learning_object_params = args[:learning_object_params]
    end

    # #get history in hash format form there respective classes
    def response
      LearningObjectSerializer.new(@learning_object).serializable_hash
    end

    def errors
      @learning_object.errors
    end
  end
end
