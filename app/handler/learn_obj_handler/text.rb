module LearnObjHandler
  class Text < LearnObjHandler::Base
    def initialize(args)
      super
    end

    def save_record
      @learning_object = learn_mod.learning_objects.build(learning_object_params)
      @learning_object.objectable = TextLearnObj.new(text_params)
      @learning_object.save
    end

    def text_params
      {
        title:            params[:card][:title],
        description:      params[:card][:description]
      }
    end

  end
end
