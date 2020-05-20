# frozen_string_literal: true

class LearningObject < ApplicationRecord
  belongs_to :learn_mod, counter_cache: :learning_objects_count
  belongs_to :objectable, polymorphic: true, dependent: :destroy

  enum learning_object_type: %i[content plot_point interaction]
  enum status: %i[drafted deleted published]

  validates :learning_object_type, inclusion: { in: learning_object_types.keys }
  validates :card_order, numericality: { only_integer: true }, presence: true
  validates :name, presence: true
  # enum learning_object_type [:email_interaction, :dialogic_interaction, :chat_learn_obj]

  accepts_nested_attributes_for :objectable, allow_destroy: true

  scope :deleted, lambda { where(status: statuses['deleted']) }
  scope :active, lambda { where.not(status: statuses['deleted']) }

  # Need different serializer names for different card details
  def serializer_name
    "#{objectable_type}Serializer".constantize
  end

end
