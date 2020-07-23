# frozen_string_literal: true

module InterstitialContentHandler
  # Needed to write common code for Interstitial Contents
  class Base
    attr_reader :params, :learning_object_params, :content

    def initialize(args)
      @params = args[:params]
      @email_lo = args[:email_learn_obj]
      @content = args[:content]
    end

    # Returns learning object JSON data
    def response
      LearningObjectSerializer.new(content).serializable_hash
    end

    def save_record
      build_record
      @content.save if valid_record
    end

    def valid_record
      content.occupiable.valid? && content.valid?
    end

    def errors
      if !content.valid?
        content.errors
      else
        content.objectable.errors
      end
    end

    def content?
      params[:content]
    end
  end
end
