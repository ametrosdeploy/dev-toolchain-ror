# frozen_string_literal: true

module AdaptiveContentHandler
  # Needed to create Text adaptive content
  class Text < AdaptiveContentHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @content.contentable ||= TextLearnObj.new
      @content.contentable.assign_attributes(text_params)
    end

    def text_params
      return {} unless content?

      {
        title: params[:content][:title]
      }
    end
  end
end
