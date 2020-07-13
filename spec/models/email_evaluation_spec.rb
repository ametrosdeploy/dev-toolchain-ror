# frozen_string_literal: true

# == Schema Information
#
# Table name: email_evaluations
#
#  id                :bigint           not null, primary key
#  user_learn_obj_id :bigint           not null
#  email             :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe EmailEvaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
