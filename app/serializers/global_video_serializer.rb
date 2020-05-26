# frozen_string_literal: true

# == Schema Information
#
# Table name: global_videos
#
#  id              :bigint           not null, primary key
#  title           :string           not null
#  description     :text
#  wistia_code     :string
#  duration        :integer
#  video_type      :integer
#  private         :boolean          default(FALSE)
#  transcript      :text
#  customer_id     :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  cached_tag_list :string
#
class GlobalVideoSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  include DateHelper
  attributes :title, :description, :wistia_code, :private, :transcript,
             :tag_list, :wistia_thumbnail_url

  attribute :duration do |global_video|
    global_video.duration.to_i.pretty_duration
  end

  attribute :thumbnail_url do |global_video|
    image_url(global_video.thumbnail)
  end

  attribute :created_on do |global_video|
    format_to_ymd(global_video.created_at)
  end

  attribute :customer do |global_video|
    CustomerSerializer.new(global_video.customer).as_json['data']
  end
end
