# frozen_string_literal: true

# == Schema Information
#
# Table name: learner_dashes
#
#  id           :bigint           not null, primary key
#  title        :string
#  description  :text
#  welcome_text :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe LearnerDash, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
