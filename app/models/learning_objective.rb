# frozen_string_literal: true

# == Schema Information
#
# Table name: learning_objectives
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class LearningObjective < ApplicationRecord
end
