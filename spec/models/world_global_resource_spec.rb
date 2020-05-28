# frozen_string_literal: true

# == Schema Information
#
# Table name: world_global_resources
#
#  id                 :bigint           not null, primary key
#  global_resource_id :bigint           not null
#  world_id           :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rails_helper'

RSpec.describe WorldGlobalResource, type: :model do
end
