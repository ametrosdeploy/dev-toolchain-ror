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
class LearnMod < ApplicationRecord
  PER_PAGE = 10
  strip_attributes

  belongs_to :world, counter_cache: :learn_mods_count

  belongs_to :lead_designer, class_name: 'User', optional: true
  belongs_to :sme, class_name: 'User', optional: true
  belongs_to :intro_video, class_name: 'GlobalVideo', optional: true

  has_many :learn_mod_organizations, dependent: :destroy
  has_many :world_organizations, through: :learn_mod_organizations

  has_many :learn_mod_skills, dependent: :destroy
  has_many :global_skills, through: :learn_mod_skills

  has_many :learn_mod_intro_docs, dependent: :destroy
  has_many :global_resources, through: :learn_mod_intro_docs

  has_many :learning_objects
  has_many :user_sections

  enum status: %i[drafted published]

  has_one_attached :photo

  validates :name, :time_to_complete, :world_id, presence: true
  validates_uniqueness_of :unique_code
  validates_uniqueness_of :name, case_sensitive: false

  accepts_nested_attributes_for :learn_mod_organizations, allow_destroy: true
  accepts_nested_attributes_for :learn_mod_skills, allow_destroy: true
  accepts_nested_attributes_for :learn_mod_intro_docs, allow_destroy: true
  accepts_nested_attributes_for :learning_objects, allow_destroy: true

  before_create :set_uniq_token
  before_save :set_cached_skill_list

  # Used for searching LearnMod
  def self.search(keyword)
    where("learn_mods.name ilike :search or learn_mods.description ilike :search
           or unique_code = :code_search or cached_skill_list ilike :search or
           worlds.name ilike :search", search: "%#{keyword}%", code_search:
                                                    keyword.delete('^0-9').to_i)
  end

  # set unique learn_mod code
  def set_uniq_token
    self.unique_code = (1..9).sort_by { rand }.join.to_i
    set_uniq_token if LearnMod.exists?(unique_code: unique_code)
  end

  # Assign exiting industry if it already exists
  def set_cached_skill_list
    self.cached_skill_list = global_skills.map(&:name).join(',')
  end

  # Valid learn_mode & make sure all the necessary data is present?
  def can_be_published?
    valid? ? true : false
  end

  def toggle_publish
    update(status: toggle_status)
  end

  def toggle_status
    published? ? LearnMod.statuses[:drafted] : LearnMod.statuses[:published]
  end

  def character_ids
    WorldOrgCharacter.where(world_organization_id: world.world_organizations
                            .pluck(:id)).pluck(:character_id)
  end

  def reorder_cards
    rec = []
    learning_objects.active.each_with_index do |lo, index|
      rec << { id: lo.id, card_order: index + 1 }
    end
    update(learning_objects_attributes: rec)
  end
end
