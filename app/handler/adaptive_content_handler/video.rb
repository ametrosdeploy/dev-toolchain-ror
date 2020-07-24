# frozen_string_literal: true

module AdaptiveContentHandler
  # Needed to create Video adaptive content
  class Video < AdaptiveContentHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @content.contentable ||= VideoLearnObj.new
      @content.contentable.assign_attributes(video_params)
    end

    def video_params
      return {} unless content?

      {
        title: params[:content][:title],
        global_video_id: params[:content][:global_video_id]
      }
    end
  end
end
