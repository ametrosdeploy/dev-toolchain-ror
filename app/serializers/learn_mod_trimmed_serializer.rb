# frozen_string_literal: true

# LearnMod serializer with less data
class LearnModTrimmedSerializer
  include FastJsonapi::ObjectSerializer
  include DateHelper
  attributes :name, :learning_objects_count

  attribute :created_on do |learn_mod|
    format_to_ymd(learn_mod.created_at)
  end

  attribute :photo_url, &:attachement_variations
end
