# frozen_string_literal: true

# == Schema Information
#
# Table name: email_learn_objs
#
#  id                    :bigint           not null, primary key
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  title                 :string
#  to_character_ids      :integer          default([]), is an Array
#  cc_character_ids      :integer          default([]), is an Array
#  email_body            :text
#  iteration_enabled     :boolean          default(FALSE)
#  iteration_level       :integer
#  iteration_explanation :text
#  chained_to            :integer
#
class EmailLearnObj < ApplicationRecord
  # Associations ...
  has_one :learning_object, as: :objectable
  has_one :learn_mod, through: :objectable
  has_many :email_responses, dependent: :destroy
  has_many  :email_skills, dependent: :destroy
  has_many :qa_conditions, dependent: :destroy
  has_many :interstitial_contents, dependent: :destroy
  belongs_to :next_chained_email, class_name: 'EmailLearnObj',
                                  foreign_key: 'chained_to',
                                  optional: true

  # Nested attributes ...
  accepts_nested_attributes_for :qa_conditions, allow_destroy: true

  # There seems to be some issue here cross-check it
  # validate :valid_characters
  validates :to_character_ids, presence: true

  # Callbacks ...
  after_commit :set_next_chained_email, if: :saved_change_to_to_character_ids?

  attr_accessor :learn_mod_id

  def set_next_chained_email
    Rails.logger.debug "*** email_learn_obj id -- #{self.id}"
    Rails.logger.debug "*** learning_object -- #{learning_object}"
    all_objs = learning_object.learn_mod.learning_objects
    card_order = learning_object.card_order
    previous_obj = all_objs.find_by(card_order: card_order - 1)
    next_obj = all_objs.find_by(card_order: card_order + 1)
    if previous_obj&.email?
      prev_email_card = previous_obj.objectable
      chained = same_to_characters?(prev_email_card) ? id : nil
      prev_email_card.update(chained_to: chained)
    end
    if next_obj&.email?
      next_email_card = next_obj.objectable
      chained = same_to_characters?(next_email_card) ? next_email_card.id : nil
      update(chained_to: chained)
    end
  end

  def same_to_characters?(another_email_lo)
    to_character_ids.sort == another_email_lo.to_character_ids.sort
  end

  def to_characters
    WorldOrgCharacter.where(id: to_character_ids)
  end

  def cc_characters
    WorldOrgCharacter.where(id: cc_character_ids)
  end

  def valid_characters
    world_char = LearnMod.find(learn_mod_id).character_ids
    errors.add(:to_character_ids, 'Invalid to characters.') unless
      validate_char?(world_char, to_character_ids)
    errors.add(:cc_character_ids, 'Invalid cc characters.') unless
      validate_char?(world_char, cc_character_ids)
  end

  def validate_char?(world_char, character_ids)
    world_char.present? && (world_char & character_ids) == world_char
  end

  def qa_condition_for(character_id)
    qa_conditions.find_by(character_id: character_id)
  end
end
