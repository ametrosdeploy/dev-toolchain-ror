# frozen_string_literal: true

# == Schema Information
#
# Table name: user_submissions
#
#  id                :bigint           not null, primary key
#  user_learn_obj_id :bigint           not null
#  user_text         :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe UserSubmission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
