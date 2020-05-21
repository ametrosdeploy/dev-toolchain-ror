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
  has_one :learn_mod, through: :learning_objects

  def to_characters
    Character.where(id: to_character_ids)
  end

  def cc_characters
    Character.where(id: cc_character_ids)
  end
end
