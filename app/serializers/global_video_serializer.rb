class GlobalVideoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :wistia_code, :duration, :video_type, :private, :transcript
end
