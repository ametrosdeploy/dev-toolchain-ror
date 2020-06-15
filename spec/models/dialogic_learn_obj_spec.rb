# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_learn_objs
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  title              :string
#  character_id       :integer
#  repeat_interaction :boolean          default(FALSE)
#  max_repeat_count   :integer
#  unlimited_repeats  :boolean          default(FALSE)
#
require 'rails_helper'

RSpec.describe DialogicLearnObj, type: :model do
end
