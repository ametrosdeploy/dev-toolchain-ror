# frozen_string_literal: true

module InterstitialContentHandler
  # Needed to write common code for Interstitial Contents
  class Base
    attr_reader :params, :content, :interstitial_content_params

    def initialize(args)
      @params = args[:params]
      @email_lo = args[:email_learn_obj]
      @content = args[:content]
      @interstitial_content_params = args[:interstitial_content_params]
    end

    # Returns learning object JSON data
    def response
      InterstitialContentSerializer.new(content).serializable_hash
    end

    def save_record
      set_interstitial_content_params && build_record
      return unless valid_record

      @content.occupiable.save
      @content.save
    end

    def valid_record
      content.occupiable.valid? && content.valid?
    end

    def errors
      if !content.valid?
        content.errors
      else
        content.occupiable.errors
      end
    end

    def content?
      params[:content]
    end

    def set_interstitial_content_params
      @content.attributes = interstitial_content_params
    end
  end
end
