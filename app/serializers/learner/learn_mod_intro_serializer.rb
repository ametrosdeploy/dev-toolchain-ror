# frozen_string_literal: true

module Learner
  # Learner LearningObject serializer
  class LearnModIntroSerializer
    include FastJsonapi::ObjectSerializer
    include DateHelper

    attributes :name, :time_to_complete, :world_id, :unique_code, :description

    attribute :photo_url, &:attachement_variations

    attribute :intro_video do |learn_mod|
      GlobalVideoSerializer.new(learn_mod.intro_video).as_json['data']
    end

    attribute :intro_documents do |learn_mod|
      GlobalResourceSerializer.new(learn_mod.global_resources).as_json['data']
    end
  end
end
