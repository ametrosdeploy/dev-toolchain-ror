# frozen_string_literal: true

class EmailLearnObj < ApplicationRecord
  has_one :learning_object, as: :objectable
  has_one :learn_mod, through: :learning_objects

  def to_characters
    Character.where(id: to_character_ids)
  end

  def cc_characters
    Character.where(id: cc_character_ids)
  end
end
