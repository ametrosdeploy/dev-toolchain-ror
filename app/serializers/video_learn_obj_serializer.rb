# frozen_string_literal: true

# == Schema Information
#
# Table name: video_learn_objs
#
#  id              :bigint           not null, primary key
#  global_video_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  title           :string
#  description     :text
#
class VideoLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :global_video_id

  attribute :global_video do |video_learn_obj|
    GlobalVideoSerializer.new(video_learn_obj.global_video).as_json['data']
  end
end
