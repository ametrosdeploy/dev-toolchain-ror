# frozen_string_literal: true

# == Schema Information
#
# Table name: text_learn_objs
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  title       :string
#  description :text
#
class TextLearnObj < ApplicationRecord
  has_one :learning_object, as: :objectable
  has_one :learn_mod, through: :learning_objects
end
