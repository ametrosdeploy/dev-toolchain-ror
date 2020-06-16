# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_questions
#
#  id                    :bigint           not null, primary key
#  concept               :string
#  question              :text
#  order                 :integer
#  dialogic_learn_obj_id :bigint           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
require 'rails_helper'

RSpec.describe DialogicQuestion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
