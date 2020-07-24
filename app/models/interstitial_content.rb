# frozen_string_literal: true

# == Schema Information
#
# Table name: interstitial_contents
#
#  id                 :bigint           not null, primary key
#  email_learn_obj_id :bigint           not null
#  content_order      :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  occupiable_type    :string           not null
#  occupiable_id      :bigint           not null
#
class InterstitialContent < ApplicationRecord
  # Association ...
  belongs_to :email_learn_obj
  belongs_to :occupiable, polymorphic: true

  # Need different serializer names for different contents
  def serializer_name
    "#{occupiable_type}Serializer".constantize
  end
end
