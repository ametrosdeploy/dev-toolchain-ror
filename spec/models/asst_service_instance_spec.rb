# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_service_instances
#
#  id           :bigint           not null, primary key
#  learn_mod_id :bigint           not null
#  guid         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe AsstServiceInstance, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
