# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_debrief_evaluations
#
#  id                     :bigint           not null, primary key
#  dialogic_evaluation_id :bigint           not null
#  key_topic_id           :bigint           not null
#  assessment_label_id    :integer
#  debrief_received       :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  key_topic_missed       :boolean          default(FALSE)
#  kt_points              :float
#  dialogic_answer_id     :integer          not null
#
require 'rails_helper'

RSpec.describe DialogicDebriefEvaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
