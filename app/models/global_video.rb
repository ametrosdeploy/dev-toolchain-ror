# frozen_string_literal: true

# == Schema Information
#
# Table name: global_videos
#
#  id              :bigint           not null, primary key
#  title           :string           not null
#  description     :text
#  wistia_code     :string
#  duration        :integer
#  video_type      :integer
#  private         :boolean          default(FALSE)
#  transcript      :text
#  customer_id     :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  cached_tag_list :string
#
class GlobalVideo < ApplicationRecord
  PER_PAGE = 10
  acts_as_ordered_taggable
  strip_attributes
  enum video_type: %i[content plot_point module_intro]

  belongs_to :customer, optional: true

  has_many :world_videos
  has_many :worlds, through: :world_videos

  has_many :video_learn_objs
  has_many :learn_mods, through: :video_learn_objs

  has_one_attached :thumbnail

  validates :customer_id, presence: true, if: :private?
  validates :title, :wistia_code, :duration, :video_type, presence: true

  # Used for searching Global Videos
  def self.search(keyword)
    where("LOWER(cached_tag_list) ILIKE :search or title ilike :search or
      transcript ilike :search", search: "%#{keyword.downcase}%")
  end
end
