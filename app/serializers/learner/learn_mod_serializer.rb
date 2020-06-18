# frozen_string_literal: true

module Learner
  # Learner Learn Mod
  class LearnModSerializer
    include FastJsonapi::ObjectSerializer
    include DateHelper
    include ImageHelper

    attributes :name, :time_to_complete, :world_id, :unique_code, :description

    attribute :photo_url do |learn_mod|
      image_url(learn_mod.photo)
    end
  end
end
