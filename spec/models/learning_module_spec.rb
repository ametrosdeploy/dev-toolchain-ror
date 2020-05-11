# == Schema Information
#
# Table name: learning_modules
#
#  id               :bigint           not null, primary key
#  name             :string
#  time_to_complete :integer
#  abstract         :text
#  world_id         :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe LearningModule, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
