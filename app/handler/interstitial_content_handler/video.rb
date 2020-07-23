# frozen_string_literal: true

module InterstitialContentHandler
  # Needed to create Video interstitial content
  class Video < InterstitialContentHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @content.occupiable ||= VideoLearnObj.new
      @content.occupiable.assign_attributes(video_params)
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
