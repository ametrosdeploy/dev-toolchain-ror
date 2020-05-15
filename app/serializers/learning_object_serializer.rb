class LearningObjectSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  include DateHelper

  attributes :name, :card_order, :learning_object_type, :learn_mod_id,
  :objectable_type, :objectable_id, :status

  attribute :created_on do |learning_object|
    format_to_ymd(learning_object.created_at)
  end
  
  attribute :card_detail do |learning_object|
    learning_object.objectable
  end

end
