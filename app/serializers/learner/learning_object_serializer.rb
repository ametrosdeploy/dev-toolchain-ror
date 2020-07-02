# frozen_string_literal: true

module Learner
  # Learner LearningObject serializer
  class LearningObjectSerializer
    include FastJsonapi::ObjectSerializer
    include ImageHelper
    include DateHelper

    attributes :name, :learning_object_type, :learn_mod_id, :objectable_type,
               :objectable_id, :card_type, :description, :assessment_scheme_id

    attribute :card_detail do |learn_obj, params|
      if params[:display]
        learn_obj.serializer_name(learn_obj.custom_learner?)
                 .new(learn_obj.objectable).as_json['data']
      end
    end

    attribute :description do |learn_obj, params|
      learn_obj.description if params[:display]
    end
  end
end
