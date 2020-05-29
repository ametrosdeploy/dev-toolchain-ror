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
class LearningObject < ApplicationRecord
  belongs_to :learn_mod
  belongs_to :objectable, polymorphic: true, dependent: :destroy

  enum learning_object_type: %i[content plot_point interaction]
  enum status: %i[drafted published archived]

  validates :learning_object_type, inclusion: { in: learning_object_types.keys }
  validates :card_order, numericality: { only_integer: true }, presence: true
  validates :name, presence: true
  # enum learning_object_type [:email_interaction, :dialogic_interaction,
  # :chat_learn_obj]

  accepts_nested_attributes_for :objectable, allow_destroy: true

  after_create :update_lo_count
  after_save :update_lo_count, if: :saved_change_to_status?
  after_destroy :update_lo_count

  scope :archived, -> { where(status: statuses['archived']).archived_order }
  scope :active, -> { where.not(status: statuses['archived']).ordered }
  scope :ordered, -> { order('card_order asc') }
  scope :archived_order, -> { order('archived_on desc') }

  # Need different serializer names for different card details
  def serializer_name
    "#{objectable_type}Serializer".constantize
  end

  def card_type
    objectable_type.underscore.split('_')[0]
  end

  # Updates LO status & maintains cards orders
  def update_status(new_status)
    archived_on = (new_status == 'archived') && Time.current || nil
    card_ordr = status == 'archived' ? new_card_order : card_order
    rec_status = update(status: new_status, archived_on: archived_on,
                        card_order: card_ordr)
    learn_mod.reorder_cards if new_status == 'archived'
    rec_status
  end

  def new_card_order
    active_lo_count + 1
  end

  def update_lo_count
    learn_mod.update(learning_objects_count: active_lo_count)
  end

  def active_lo_count
    learn_mod.learning_objects.active.count
  end
end
