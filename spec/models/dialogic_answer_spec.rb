# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_answers
#
#  id                     :bigint           not null, primary key
#  dialogic_evaluation_id :bigint           not null
#  dialogic_question_id   :bigint           not null
#  answer                 :text
#  evaluated              :boolean          default(FALSE)
#  follow_up_answer       :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  character_response     :text
#  follow_up_question     :text
#  question_variation_id  :integer
#
require 'rails_helper'

RSpec.describe DialogicAnswer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
