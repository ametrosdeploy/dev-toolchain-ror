# frozen_string_literal: true

# == Schema Information
#
# Table name: nlu_sentiments
#
#  id                 :bigint           not null, primary key
#  learning_object_id :bigint           not null
#  sentiment          :integer
#  score              :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  from_ideal_input   :boolean
#
require 'rails_helper'

RSpec.describe NluSentiment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
