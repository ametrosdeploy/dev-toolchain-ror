# frozen_string_literal: true

# == Schema Information
#
# Table name: cutomer_learn_mods
#
#  id           :bigint           not null, primary key
#  customer_id  :bigint           not null
#  learn_mod_id :bigint           not null
#  detached     :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe CutomerLearnMod, type: :model do
end
