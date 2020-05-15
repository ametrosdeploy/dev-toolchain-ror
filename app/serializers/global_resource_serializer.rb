class GlobalResourceSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  include DateHelper
  attributes :title, :description, :resource_type, :private, :content_type

  attribute :resource_url do |global_resource|
    image_url(global_resource.attachment)
  end

  attribute :created_on do |global_resource|
    format_to_ymd(global_resource.created_at)
  end

  attribute :customer do |global_resource|
    CustomerSerializer.new(global_resource.customer).as_json['data']
  end
end
