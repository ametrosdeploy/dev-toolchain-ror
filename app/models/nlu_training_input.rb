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
#  name               :string
#  order_num          :integer
#
class NluTrainingInput < ApplicationRecord
  # Association ...
  belongs_to :learning_object
end
