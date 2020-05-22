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
#
class LearningObject < ApplicationRecord
  belongs_to :learn_mod, counter_cache: :learning_objects_count
  belongs_to :objectable, polymorphic: true, dependent: :destroy

  enum learning_object_type: %i[content plot_point interaction]
  enum status: %i[drafted published archived]

  validates :learning_object_type, inclusion: { in: learning_object_types.keys }
  validates :card_order, numericality: { only_integer: true }, presence: true
  validates :name, presence: true
  # enum learning_object_type [:email_interaction, :dialogic_interaction,
  # :chat_learn_obj]

  accepts_nested_attributes_for :objectable, allow_destroy: true

  scope :archived, -> { where(status: statuses['archived']).ordered }
  scope :active, -> { where.not(status: statuses['archived']).ordered }
  scope :ordered, -> { order('card_order asc') }

  # Need different serializer names for different card details
  def serializer_name
    "#{objectable_type}Serializer".constantize
  end
end
