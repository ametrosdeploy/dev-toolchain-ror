# frozen_string_literal: true

# == Schema Information
#
# Table name: nlu_training_inputs
#
#  id                 :bigint           not null, primary key
#  message            :text
#  email_learn_obj_id :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class NluTrainingInput < ApplicationRecord
  # Association ...
  belongs_to :email_learn_obj
end
