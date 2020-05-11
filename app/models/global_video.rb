class GlobalVideo < ApplicationRecord
  PER_PAGE = 10
  acts_as_taggable
  enum video_type: [:content, :plot_point, :module_intro]

  belongs_to :customer

  has_many :world_videos
  has_many :worlds, through: :world_videos

  has_many :video_learn_objs
  has_many :learn_mods through: :video_learn_objs
  
  has_one_attached :wistia_thumbnail

  validates :customer_id, presence: true, if: :private?
  validates :title, presence: true

  # Used for searching Global Videos
  def self.search keyword
    where("title ilike :lsearch or description = :search or description ilike :lsearch", 
      search: "%#{keyword}%")
  end

end
