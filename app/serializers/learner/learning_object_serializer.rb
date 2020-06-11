# frozen_string_literal: true

module Learner
  # Learner LearningObject serializer
  class LearningObjectSerializer
    include FastJsonapi::ObjectSerializer
    include ImageHelper
    include DateHelper

    attributes :name, :card_order, :learning_object_type, :learn_mod_id,
               :objectable_type, :objectable_id, :status, :card_type,
               :description

    attribute :created_on do |learning_object|
      format_to_ymd(learning_object.created_at)
    end

    attribute :archived_on do |learning_object|
      format_to_ymd(learning_object.archived_on)
    end

    attribute :card_detail do |learn_obj|
      learn_obj.serializer_name.new(learn_obj.objectable).as_json['data']
    end
  end
end
