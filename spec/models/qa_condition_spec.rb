# frozen_string_literal: true

# == Schema Information
#
# Table name: qa_conditions
#
#  id                 :bigint           not null, primary key
#  email_learn_obj_id :bigint           not null
#  character_id       :integer
#  ooto_response      :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rails_helper'

RSpec.describe QaCondition, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
