# frozen_string_literal: true

# == Schema Information
#
# Table name: slide_learn_objs
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  has_caption :boolean          default(TRUE)
#
class SlideLearnObj < ApplicationRecord
  # Associations ...
  # -- if LO
  has_one :learning_object, as: :objectable
  has_one :learn_mod, through: :learning_objects
  # -- if interstitial content
  has_one :interstitial_content, as: :occupiable
  has_one :email_learn_obj, through: :interstitial_contents

  has_many :slider_images, dependent: :destroy
  accepts_nested_attributes_for :slider_images, allow_destroy: true
end
