# frozen_string_literal: true

module AdaptiveContentHandler
  # Needed to create File adaptive content
  class File < AdaptiveContentHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @content.contentable ||= FileLearnObj.new
      @content.contentable.assign_attributes(file_params)
    end

    def file_params
      return {} unless content?

      {
        global_resource_id: params[:content][:global_resource_id]
      }
    end
  end
end
