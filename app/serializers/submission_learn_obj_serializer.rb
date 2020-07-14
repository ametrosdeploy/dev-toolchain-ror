# frozen_string_literal: true

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
class SubmissionLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :has_text, :has_file_upload
end
