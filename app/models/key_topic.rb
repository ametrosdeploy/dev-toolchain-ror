# frozen_string_literal: true

# == Schema Information
#
# Table name: key_topics
#
#  id                   :bigint           not null, primary key
#  dialogic_question_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  asst_entity_id       :bigint           not null
#
class KeyTopic < ApplicationRecord
  # Associations ...
  belongs_to :dialogic_question
  belongs_to :asst_entity
  has_many :dialogic_assmnt_items, dependent: :destroy
  has_one :missed_assmnt_item, dependent: :destroy

  # validations ...
  validates_presence_of :dialogic_question
  validates_presence_of :asst_entity

  # Nested Attributes ...
  # accepts_nested_attributes_for :asst_entity
end
