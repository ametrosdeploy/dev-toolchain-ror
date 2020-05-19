# frozen_string_literal: true

module LearnObjHandler
  class Video < LearnObjHandler::Base
    def initialize(args)
      super
    end

    def save_record
      @learning_object = @learn_mod.learning_objects
                                   .build(learning_object_params)
      @learning_object.objectable = VideoLearnObj.new(video_params)
      @learning_object.save
    end

    def video_params
      {
        title: params[:card][:title],
        description: params[:card][:description],
        global_video_id: params[:card][:global_video_id]
      }
    end
  end
end
