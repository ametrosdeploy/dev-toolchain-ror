# == Schema Information
#
# Table name: user_submissions
#
#  id                :bigint           not null, primary key
#  user_learn_obj_id :bigint           not null
#  user_text         :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class UserSubmission < ApplicationRecord
  belongs_to :user_learn_obj
  has_one_attached :attachment
  validate :content_type, :validate_attachment

  def validate_attachment
    return unless file_upload?

    if !attachment.attached?
      errors.add(:attachment, 'can not be blank.')
    elsif !valid_attachment?
      errors.add(:attachment, 'Must be a PDF file.')
    end
  end

  def content_type
    return unless submission_lo.has_text? && user_text.blank?

    errors.add(:user_text, 'can not be blank')
  end

  def valid_attachment?
    attachment.content_type.in?(['application/pdf'])
  end

  def submission_lo
    user_learn_obj.learning_object.objectable
  end

  def file_upload?
    submission_lo.has_file_upload?
  end
end
