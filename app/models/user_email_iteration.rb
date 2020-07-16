# frozen_string_literal: true

# == Schema Information
#
# Table name: user_email_iterations
#
#  id                       :bigint           not null, primary key
#  email                    :text
#  iteration                :float
#  response                 :text
#  user_email_evaluation_id :bigint           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class UserEmailIteration < ApplicationRecord
  # Associations ...
  belongs_to :user_email_evaluation
  has_many :user_response_variations, dependent: :destroy
end
