# frozen_string_literal: true

class GlobalVideoSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  include DateHelper
  attributes :title, :description, :wistia_code, :duration, :video_type,
             :private, :transcript, :tag_list

  attribute :wistia_thumbnail_url do |global_video|
    image_url(global_video.wistia_thumbnail)
  end

  attribute :created_on do |global_video|
    format_to_ymd(global_video.created_at)
  end

  attribute :customer do |global_video|
    CustomerSerializer.new(global_video.customer).as_json['data']
  end
end
