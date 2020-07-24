# frozen_string_literal: true

module AdaptiveContentHandler
  # Create adaptive handler
  class CreateManager
    def self.for(args)
      case args[:content_type]
      when 1
        AdaptiveContentHandler::Video.new(args)
      when 2
        AdaptiveContentHandler::Text.new(args)
      when 3
        AdaptiveContentHandler::Slide.new(args)
      when 4
        AdaptiveContentHandler::File.new(args)
      else
        false
      end
    end
  end
end
