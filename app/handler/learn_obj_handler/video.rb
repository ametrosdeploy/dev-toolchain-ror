# frozen_string_literal: true

module LearnObjHandler
  class Video < LearnObjHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @learning_object.objectable ||= VideoLearnObj.new
      @learning_object.objectable.assign_attributes(video_params)
    end

    def video_params
      return {} unless has_card?
      {
        title: params[:card][:title],
        description: params[:card][:description],
        global_video_id: params[:card][:global_video_id]
      }
    end
  end
end
