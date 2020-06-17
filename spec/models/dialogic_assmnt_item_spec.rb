# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_assmnt_items
#
#  id                  :bigint           not null, primary key
#  key_topic_id        :bigint           not null
#  assessment_label_id :bigint           not null
#  value_count_min     :integer
#  value_count_max     :integer
#  points              :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'rails_helper'

RSpec.describe DialogicAssmntItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
