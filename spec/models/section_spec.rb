# frozen_string_literal: true

# == Schema Information
#
# Table name: sections
#
#  id                   :bigint           not null, primary key
#  cutomer_learn_mod_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
require 'rails_helper'

RSpec.describe Section, type: :model do
end
