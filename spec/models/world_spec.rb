# == Schema Information
#
# Table name: worlds
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  description      :text
#  world_code       :integer          not null
#  is_private       :boolean
#  learn_mods_count :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  customer_id      :integer
#
require 'rails_helper'

RSpec.describe World, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
