# frozen_string_literal: true

# == Schema Information
#
# Table name: email_learn_objs
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  title            :string
#  to_character_ids :integer          default([]), is an Array
#  cc_character_ids :integer          default([]), is an Array
#  email_body       :text
#
require 'rails_helper'

RSpec.describe EmailLearnObj, type: :model do
end
