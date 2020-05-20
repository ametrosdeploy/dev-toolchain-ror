class VideoLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :global_video_id

  attribute :global_video do |video_learn_obj|
    GlobalVideoSerializer.new(video_learn_obj.global_video).as_json['data']
  end

end
