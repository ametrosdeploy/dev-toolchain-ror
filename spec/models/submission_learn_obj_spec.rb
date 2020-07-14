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
require 'rails_helper'

RSpec.describe SubmissionLearnObj, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
