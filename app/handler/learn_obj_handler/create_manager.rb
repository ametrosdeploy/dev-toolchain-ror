# frozen_string_literal: true

module LearnObjHandler
  # Create Learning objects handler
  class CreateManager
    def self.for(args)
      case args[:card_type]
      when 1
        LearnObjHandler::Email.new(args)
      when 2
        LearnObjHandler::Video.new(args)
      when 3
        LearnObjHandler::Text.new(args)
      else
        false
      end
    end
  end
end
