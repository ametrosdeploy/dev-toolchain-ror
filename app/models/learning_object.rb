# frozen_string_literal: true

class LearningObject < ApplicationRecord
  belongs_to :learn_mod, counter_cache: :learning_objects_count
  belongs_to :objectable, polymorphic: true

  enum learning_object_type: [:content, :plot_point, :interaction]
  enum status: [:drafted, :deleted, :published]

  validates :learning_object_type, inclusion: { in: learning_object_types.keys }
  validates :card_order, numericality: { only_integer: true }, presence: true
  validates :name, presence: true
  # enum learning_object_type [:email_interaction, :dialogic_interaction, :chat_learn_obj]

end
