# frozen_string_literal: true

module Learner
  # Learner LearningObject serializer
  class UserLearnObjSerializer
    include FastJsonapi::ObjectSerializer
    attributes :user_section_id, :complete, :learning_object_id

    attribute :user_section do |user_learn_obj|
      Learner::UserSectionSerializer.new(user_learn_obj.user_section)
                                    .as_json['data']
    end
    attribute :learning_object do |user_learn_obj, params|
      id = params[:next_step_id]
      args = { display: (id.nil? ? true : id == user_learn_obj.id) }
      Learner::LearningObjectSerializer.new(user_learn_obj.learning_object,
                                            { params: args }).as_json['data']
    end
  end
end
