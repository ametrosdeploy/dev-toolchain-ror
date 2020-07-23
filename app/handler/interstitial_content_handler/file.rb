# frozen_string_literal: true

module InterstitialContentHandler
  # Needed to create File interstitial content
  class File < InterstitialContentHandler::Base
    def initialize(args)
      super
    end

    def build_record
      @content.occupiable ||= FileLearnObj.new
      @content.occupiable.assign_attributes(file_params)
    end

    def file_params
      return {} unless content?

      {
        global_resource_id: params[:content][:global_resource_id]
      }
    end
  end
end
