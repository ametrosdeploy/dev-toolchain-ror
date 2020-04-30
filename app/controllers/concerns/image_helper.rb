module ImageHelper
  extend ActiveSupport::Concern

  class_methods do
    def image_url(obj)
      obj.attached? && Rails.application.routes.url_helpers.rails_blob_path(obj, only_path: true)
    end
  end
end
