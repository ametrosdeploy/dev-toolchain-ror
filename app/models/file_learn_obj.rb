# frozen_string_literal: true

# == Schema Information
#
# Table name: file_learn_objs
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  global_resource_id :bigint           not null
#
class FileLearnObj < ApplicationRecord
  # Associations ...
  belongs_to :global_resource
  # -- if LO
  has_one :learning_object, as: :objectable
  has_one :learn_mod, through: :learning_objects
  # -- if interstitial content
  has_one :interstitial_content, as: :occupiable
  has_one :email_learn_obj, through: :interstitial_contents
  # -- if adaptive content
  has_one :adaptive_content, as: :contentable
  has_one :adaptable, through: :adaptive_contents

  validate :global_resource_type

  def global_resource_type
    return unless global_resource

    errors.add(:global_resource_id, 'Please select/upload pdf.') unless
      global_resource.pdf?
  end
end
