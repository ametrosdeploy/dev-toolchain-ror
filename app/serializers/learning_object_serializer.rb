# frozen_string_literal: true

# == Schema Information
#
# Table name: learning_objects
#
#  id                   :bigint           not null, primary key
#  name                 :string
#  learn_mod_id         :bigint           not null
#  card_order           :integer
#  learning_object_type :integer
#  objectable_type      :string           not null
#  objectable_id        :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  status               :integer          default("drafted")
#  archived_on          :datetime
#
class LearningObjectSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  include DateHelper

  attributes :name, :card_order, :learning_object_type, :learn_mod_id,
             :objectable_type, :objectable_id, :status, :card_type, :description

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
