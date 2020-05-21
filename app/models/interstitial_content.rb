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
#
class InterstitialContent < ApplicationRecord
  belongs_to :email_learn_obj
end
