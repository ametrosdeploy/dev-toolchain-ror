# == Schema Information
#
# Table name: submission_learn_objs
#
#  id              :bigint           not null, primary key
#  has_text        :boolean          default(FALSE)
#  has_file_upload :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class SubmissionLearnObj < ApplicationRecord
  has_one :learning_object, as: :objectable
  has_one :learn_mod, through: :objectable
end
