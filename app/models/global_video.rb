class GlobalVideo < ApplicationRecord
  belongs_to :customer

  has_many :world_videos
  has_many :worlds, through: :world_videos

  has_many :video_learn_objs
  has_many :learn_mods through: :video_learn_objs
  
  has_one_attached :wistia_thumbnail
end
