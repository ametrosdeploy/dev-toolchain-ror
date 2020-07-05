# frozen_string_literal: true

# == Schema Information
#
# Table name: nlu_training_inputs
#
#  id                 :bigint           not null, primary key
#  message            :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  learning_object_id :bigint           not null
#
require 'rails_helper'

RSpec.describe NluTrainingInput, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
