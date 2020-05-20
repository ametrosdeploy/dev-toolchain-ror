# frozen_string_literal: true

class GlobalResourceSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  include DateHelper
  attributes :title, :description, :resource_type, :private

  attribute :resource_url do |global_resource|
    image_url(global_resource.attachment)
  end

  attribute :created_on do |global_resource|
    format_to_ymd(global_resource.created_at)
  end

  attribute :customer do |global_resource|
    CustomerSerializer.new(global_resource.customer).as_json['data']
  end

  attribute :resource_size do |global_resource|
    to_kb(global_resource.attachment_attachment.blob.byte_size)
  end

  attribute :file_name do |global_resource|
    global_resource.attachment_attachment.blob.filename
  end

  attribute :tag_list do |global_resource|
    global_resource.cached_tag_list
  end

end
