# frozen_string_literal: true

module AdaptiveContentHandler
  # Needed to create Slide adaptive content
  class Slide < AdaptiveContentHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @content.contentable ||= SlideLearnObj.new
      @content.contentable.assign_attributes(slide_params)
    end

    def slide_params
      return {} unless content?

      slider_data = params[:content].permit![:slider_images_attributes]
      {
        slider_images_attributes: slider_data,
        has_caption: params[:content][:has_caption]
      }
    end
  end
end
