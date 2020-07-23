# frozen_string_literal: true

module InterstitialContentHandler
  # Needed to create Text interstitial content
  class Text < InterstitialContentHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @content.occupiable ||= TextLearnObj.new
      @content.occupiable.assign_attributes(text_params)
    end

    def text_params
      return {} unless content?

      {
        title: params[:content][:title]
      }
    end
  end
end
