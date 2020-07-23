# frozen_string_literal: true

module InterstitialContentHandler
  # Needed to create Slide interstitial content
  class Slide < InterstitialContentHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @content.occupiable ||= SlideLearnObj.new
      @content.occupiable.assign_attributes(slide_params)
    end

    def slide_params
      return {} unless card?

      slider_data = params[:content].permit![:slider_images_attributes]
      {
        slider_images_attributes: slider_data,
        has_caption: params[:content][:has_caption]
      }
    end
  end
end
