# == Schema Information
#
# Table name: worlds
#
#  id               :bigint           not null, primary key
#  description      :text
#  is_private       :boolean
#  learn_mods_count :integer          default(0)
#  name             :string           not null
#  world_code       :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  customer_id      :bigint           not null
#
# Indexes
#
#  index_worlds_on_customer_id  (customer_id)
#  index_worlds_on_world_code   (world_code) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#
require 'rails_helper'

RSpec.describe World, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
