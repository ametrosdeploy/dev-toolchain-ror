# frozen_string_literal: true

module InterstitialContentHandler
  # Create Learning objects handler
  class CreateManager
    def self.for(args)
      case args[:content_type]
      when 1
        InterstitialContentHandler::Video.new(args)
      when 2
        InterstitialContentHandler::Text.new(args)
      when 3
        InterstitialContentHandler::Slide.new(args)
      when 4
        InterstitialContentHandler::File.new(args)
      else
        false
      end
    end
  end
end
