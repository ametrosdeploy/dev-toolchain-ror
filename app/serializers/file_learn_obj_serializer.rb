# frozen_string_literal: true

# File Learn Object serializer
class FileLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  attributes :global_resource_id

  attribute :resource_url do |file_learn_obj|
    image_url(file_learn_obj.global_resource.attachment)
  end
end
