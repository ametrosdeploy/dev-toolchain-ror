# frozen_string_literal: true

# Needed to style/format Image
module ImageHelper
  extend ActiveSupport::Concern

  class_methods do
    def image_url(obj)
      obj.attached? && Rails.application
                            .routes.url_helpers
                            .rails_blob_path(obj, only_path: true)
    end

    # Converts image byte_size to KB
    def to_kb(size)
      size && "#{size / 1000} Kb" || 0
    end
  end
end
