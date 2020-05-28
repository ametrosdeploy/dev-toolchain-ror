# frozen_string_literal: true

# == Schema Information
#
# Table name: email_learn_objs
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  title            :string
#  description      :text
#  to_character_ids :integer          default([]), is an Array
#  cc_character_ids :integer          default([]), is an Array
#
class EmailLearnObj < ApplicationRecord
  has_one :learning_object, as: :objectable
  has_one :learn_mod, through: :objectable

  # There seems to be some issue here cross-check it
  # validate :valid_characters

  attr_accessor :learn_mod_id

  def to_characters
    Character.where(id: to_character_ids)
  end

  def cc_characters
    Character.where(id: cc_character_ids)
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
end
