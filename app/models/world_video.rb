# frozen_string_literal: true

# == Schema Information
#
# Table name: world_videos
#
#  id              :bigint           not null, primary key
#  global_video_id :bigint           not null
#  world_id        :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class WorldVideo < ApplicationRecord
  belongs_to :global_video
  belongs_to :world
end
