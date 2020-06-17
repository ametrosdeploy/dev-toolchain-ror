# frozen_string_literal: true

# == Schema Information
#
# Table name: key_topics
#
#  id                   :bigint           not null, primary key
#  dialogic_question_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
require 'rails_helper'

RSpec.describe KeyTopic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
