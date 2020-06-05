# frozen_string_literal: true

module LearnObjHandler
  # Needed to create Video Learn Object
  class Video < LearnObjHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @learning_object.objectable ||= VideoLearnObj.new
      @learning_object.objectable.assign_attributes(video_params)
    end

    def video_params
      return {} unless card?

      {
        title: params[:card][:title],
        global_video_id: params[:card][:global_video_id]
      }
    end
  end
end
