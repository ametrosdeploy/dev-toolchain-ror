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
#  next_iteration_required  :boolean          default(FALSE)
#
require 'rails_helper'

RSpec.describe UserEmailIteration, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
