# frozen_string_literal: true

# == Schema Information
#
# Table name: learn_mod_organizations
#
#  id                      :bigint           not null, primary key
#  is_learner_organization :boolean
#  abstract                :text
#  learn_mod_id            :bigint           not null
#  world_organization_id   :bigint           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  world_role_id           :integer
#
require 'rails_helper'

RSpec.describe LearnModOrganization, type: :model do
end
