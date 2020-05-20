# frozen_string_literal: true

class LearningObjectSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  include DateHelper

  attributes :name, :card_order, :learning_object_type, :learn_mod_id,
             :objectable_type, :objectable_id, :status

  attribute :created_on do |learning_object|
    format_to_ymd(learning_object.created_at)
  end

  attribute :card_detail do |learn_obj|
    learn_obj.serializer_name.new(learn_obj.objectable).as_json['data']
  end
end
