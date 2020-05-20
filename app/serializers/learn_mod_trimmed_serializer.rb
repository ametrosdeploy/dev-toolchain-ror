class LearnModTrimmedSerializer
  include FastJsonapi::ObjectSerializer
  include DateHelper
  include ImageHelper
  attributes :name, :learning_objects_count

  attribute :created_on do |learn_mod|
    format_to_ymd(learn_mod.created_at)
  end

  attribute :photo_url do |learn_mod|
    image_url(learn_mod.photo)
  end

end
