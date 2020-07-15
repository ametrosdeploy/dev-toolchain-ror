# frozen_string_literal: true

module Learner
  # Learner Learn Mod
  class LearnModSerializer
    include FastJsonapi::ObjectSerializer
    include DateHelper

    attributes :name, :time_to_complete, :world_id, :unique_code, :description

    attribute :photo_url, &:attachement_variations
  end
end
