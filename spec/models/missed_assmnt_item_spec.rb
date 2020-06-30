# frozen_string_literal: true

# == Schema Information
#
# Table name: missed_assmnt_items
#
#  id                     :bigint           not null, primary key
#  key_topic_id           :bigint           not null
#  has_follow_up_question :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe MissedAssmntItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
