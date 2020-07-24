# frozen_string_literal: true

# == Schema Information
#
# Table name: adaptive_contents
#
#  id               :bigint           not null, primary key
#  title            :string
#  description      :text
#  adaptable_type   :string           not null
#  adaptable_id     :bigint           not null
#  contentable_type :string           not null
#  contentable_id   :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe AdaptiveContent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
