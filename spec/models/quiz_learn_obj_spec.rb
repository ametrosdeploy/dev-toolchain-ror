# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_learn_objs
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  title           :string
#  description     :text
#  score_view_type :integer          default("numeric")
#
require 'rails_helper'

RSpec.describe QuizLearnObj, type: :model do
end
