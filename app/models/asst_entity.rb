# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_entities
#
#  id                 :bigint           not null, primary key
#  name               :string
#  learning_object_id :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class AsstEntity < ApplicationRecord
  belongs_to :learning_object
  has_many :asst_entity_values

  accepts_nested_attributes_for :asst_entity_values, allow_destroy: true
end
