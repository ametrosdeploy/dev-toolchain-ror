# frozen_string_literal: true

# == Schema Information
#
# Table name: overall_assmnt_items
#
#  id                  :bigint           not null, primary key
#  min_score           :float
#  max_score           :float
#  feedback            :text
#  assessment_label_id :bigint           not null
#  learning_object_id  :bigint           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'rails_helper'

RSpec.describe OverallAssmntItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
