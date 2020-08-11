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
#  overall_assmnt_item_id   :bigint
#  qa_condition_hit         :boolean          default(FALSE), not null
#  next_iteration_required  :boolean          default(FALSE)
#
class UserEmailIteration < ApplicationRecord
  # Associations ...
  belongs_to :user_email_evaluation
  belongs_to :overall_assmnt_item, optional: true

  has_many :user_response_variations, dependent: :destroy
  has_many :user_email_iteration_responses, dependent: :destroy

  # Callbacks ...
  after_create :update_iteration

  accepts_nested_attributes_for :user_email_evaluation

  # Validations ...
  validates :email, presence: true, length: { minimum: 75 }, on: :create
  validates :iteration, numericality: { only_integer: true }, presence: true

  validate :iteration_retry_count

  scope :with_ordered, -> { order('created_at desc') }

  # Methods ...
  def update_iteration
    prev_itrerations = user_email_evaluation
               .user_email_iterations - [self]
    prev_itr = prev_itrerations&.last&.iteration
    self.iteration = (prev_itr || 0) + 1
  end

  # Returns error message when a new iteration can not be added
  def iteration_retry_count
    return if user_email_evaluation.valid_iteration?
    errors.add(:iteration, 'You have exceeded maximum iteration limit.')
  end
end
