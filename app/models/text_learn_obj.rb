# frozen_string_literal: true

# == Schema Information
#
# Table name: text_learn_objs
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#
class TextLearnObj < ApplicationRecord
  # Associations ...
  # -- if LO
  has_one :learning_object, as: :objectable
  has_one :learn_mod, through: :learning_objects
  # -- if interstitial content
  has_one :interstitial_content, as: :occupiable
  has_one :email_learn_obj, through: :interstitial_contents
  # -- if adaptive content
  has_one :adaptive_content, as: :contentable
  has_one :adaptable, through: :adaptive_contents
end
