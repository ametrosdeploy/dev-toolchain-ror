# frozen_string_literal: true

# == Schema Information
#
# Table name: learning_objects
#
#  id                   :bigint           not null, primary key
#  name                 :string
#  learn_mod_id         :bigint           not null
#  card_order           :integer
#  learning_object_type :integer
#  objectable_type      :string           not null
#  objectable_id        :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  status               :integer          default("drafted")
#  archived_on          :datetime
#
require 'rails_helper'

RSpec.describe LearningObject, type: :model do
end
