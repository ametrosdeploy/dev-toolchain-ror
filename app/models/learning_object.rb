# frozen_string_literal: true

# == Schema Information
#
# Table name: learning_objects
#
#  id                          :bigint           not null, primary key
#  name                        :string
#  learn_mod_id                :bigint           not null
#  card_order                  :integer
#  learning_object_type        :integer
#  objectable_type             :string           not null
#  objectable_id               :bigint           not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  status                      :integer          default("drafted")
#  archived_on                 :datetime
#  description                 :text
#  overall_assessment_required :boolean          default(FALSE), not null
#  assessment_scheme_id        :bigint
#  admin_notes                 :text
#
class LearningObject < ApplicationRecord
  # Associations ...
  belongs_to :learn_mod
  belongs_to :objectable, polymorphic: true, dependent: :destroy
  belongs_to :assessment_scheme, optional: true
  # -- Assistant Associations..
  has_one :assistant_dialog_skill, dependent: :destroy
  has_many :asst_entities, dependent: :destroy
  has_many :asst_intents, dependent: :destroy
  has_many :overall_assmnt_items, dependent: :destroy
  # -- NLU Associations..
  has_many :nlu_training_inputs
  has_many :nlu_concepts
  has_many :nlu_entities
  has_many :nlu_keywords
  has_one :nlu_emotion_score
  has_one :nlu_sentiment

  # Enums ...
  enum learning_object_type: %i[content plot_point interaction]
  enum status: %i[drafted published archived]

  # Validations ...
  validates :learning_object_type, inclusion: { in: learning_object_types.keys }
  validates :card_order, numericality: { only_integer: true }, presence: true
  validates :name, presence: true
  # enum learning_object_type [:email_interaction, :dialogic_interaction,
  # :chat_learn_obj]
  # validate :validate_content_type

  # Nested Attributes ...
  accepts_nested_attributes_for :objectable, allow_destroy: true

  # Callbacks ...
  after_create :update_lo_count, :overall_assmnt_item_setup
  after_save :update_lo_count, if: :saved_change_to_status?
  after_destroy :update_lo_count
  before_update :overall_assmnt_item_setup

  # Scopes ...
  scope :archived, -> { where(status: statuses['archived']).archived_order }
  scope :active, -> { where.not(status: statuses['archived']).ordered }
  scope :published, -> { where(status: statuses['published']).ordered }
  scope :ordered, -> { order('card_order asc') }
  scope :archived_order, -> { order('archived_on desc') }

  # Need different serializer names for different card details
  def serializer_name(learner = false)
    if learner
      "Learner::#{objectable_type}Serializer".constantize
    else
      "#{objectable_type}Serializer".constantize
    end
  end

  # If you define a custom serializer for LO, set it here
  def custom_learner?
    ['DialogicLearnObj'].include?(objectable_type)
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

  # Validates available content types
  def validate_content_type
    if plot_point? && !valid_plot_point?
      errors.add(:learning_object_type, 'Not a valid plot point LO.')
    elsif content? && !valid_content?
      errors.add(:learning_object_type, 'Not a valid content LO.')
    elsif !valid_interaction?
      errors.add(:learning_object_type, 'Not a valid interaction LO.')
    end
  end

  def valid_plot_point?
    %w[text video slide email].include?(card_type)
  end

  def valid_content?
    %w[text video slide file].include?(card_type)
  end

  def valid_interaction?
    %w[quiz chat email dialogic].include?(card_type)
  end

  def overall_assmnt_item_setup
    return unless assessment_scheme.present? && assessment_scheme_id_changed?

    overall_assmnt_items&.destroy_all
    labels = assessment_scheme.assessment_labels
    records = labels.map do |label|
      { learning_object_id: id, assessment_label_id: label.id,
        created_at: DateTime.now, updated_at: DateTime.now }
    end
    OverallAssmntItem.insert_all(records)
  end
end
