# frozen_string_literal: true

module AdaptiveContentHandler
  # Needed to write common code for adaptive Contents
  class Base
    attr_reader :params, :content, :adaptive_content_params

    def initialize(args)
      @params = args[:params]
      @adaptive_content_params = args[:adaptive_content_params]
      @content = args[:content]
    end

    # Returns learning object JSON data
    def response
      AdaptiveContentSerializer.new(content).serializable_hash
    end

    def save_record
      set_adaptive_content_params && build_record
      return unless valid_record

      @content.contentable.save
      @content.save
    end

    def valid_record
      content.contentable.valid? && content.valid?
    end

    def errors
      if !content.valid?
        content.errors
      else
        content.contentable.errors
      end
    end

    def content?
      params[:content]
    end

    def set_adaptive_content_params
      @content.attributes = adaptive_content_params
    end
  end
end
