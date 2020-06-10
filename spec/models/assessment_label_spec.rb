# frozen_string_literal: true

# == Schema Information
#
# Table name: assessment_labels
#
#  id                   :bigint           not null, primary key
#  name                 :string
#  order                :integer
#  assessment_scheme_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
require 'rails_helper'

RSpec.describe AssessmentLabel, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
