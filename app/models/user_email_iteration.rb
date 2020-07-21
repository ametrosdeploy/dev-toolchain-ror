# frozen_string_literal: true

# == Schema Information
#
# Table name: user_email_iterations
#
#  id                       :bigint           not null, primary key
#  email                    :text
#  iteration                :integer          default(0)
#  user_email_evaluation_id :bigint           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class UserEmailIteration < ApplicationRecord
  # Associations ...
  belongs_to :user_email_evaluation
  has_many :user_response_variations, dependent: :destroy
  has_many :user_email_iteration_responses, dependent: :destroy

  # Callbacks ...
  after_create :update_iteration

  # Validations ...
  validates :email, presence: true, length: { minimum: 75 }, on: :create
  validates :iteration, numericality: { only_integer: true }, presence: true

  # Methods ...
  def update_iteration
    prev_itrerations = user_email_evaluation
               .user_email_iterations - [self]
    prev_itr = prev_itrerations&.last&.iteration
    self.iteration = prev_itr.blank? ? 0 : (prev_itr + 1)
  end
end
