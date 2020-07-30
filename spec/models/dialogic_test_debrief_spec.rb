# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_test_debriefs
#
#  id                  :bigint           not null, primary key
#  dialogic_test_id    :bigint           not null
#  key_topic_id        :bigint           not null
#  assessment_label_id :bigint
#  debrief_received    :text
#  key_topic_missed    :boolean
#  kt_points           :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'rails_helper'

RSpec.describe DialogicTestDebrief, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
