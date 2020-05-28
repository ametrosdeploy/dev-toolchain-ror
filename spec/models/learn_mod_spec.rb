# frozen_string_literal: true

# == Schema Information
#
# Table name: learn_mods
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  time_to_complete       :integer
#  abstract               :text
#  world_id               :bigint           not null
#  intro_video_id         :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  unique_code            :integer          not null
#  learning_objects_count :integer          default(0)
#  description            :text
#  lead_designer_id       :integer
#  sme_id                 :integer
#  learning_objectives    :text
#  notes                  :text
#  cached_skill_list      :string
#  status                 :integer          default("drafted")
#
require 'rails_helper'

RSpec.describe LearnMod, type: :model do
end
