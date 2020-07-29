# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_learn_objs
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  title        :string
#  character_id :integer
#  introduction :text
#  conclusion   :text
#
class DialogicLearnObj < ApplicationRecord
  # Associations ...
  belongs_to :character, class_name: 'WorldOrgCharacter'
  has_one :learning_object, as: :objectable
  has_one :learn_mod, through: :learning_objects
  has_many :dialogic_questions, dependent: :destroy

  # Validations ...
  validates :title, presence: true
  # validates :max_repeat_count,
  #           numericality: { greater_than: 0 },
  #           if: :max_repeat_count?

  # Nested attributes ...
  accepts_nested_attributes_for :dialogic_questions, allow_destroy: true
end
