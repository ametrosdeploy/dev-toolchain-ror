# frozen_string_literal: true

class LearnMod < ApplicationRecord
  PER_PAGE = 10
  strip_attributes

  belongs_to :world, counter_cache: :learn_mods_count

  belongs_to :lead_designer, class_name: 'User'
  belongs_to :sme, class_name: 'User'
  belongs_to :intro_video, class_name: 'GlobalVideo'

  has_many :learn_mod_organizations, dependent: :destroy
  has_many :world_organizations, through: :learn_mod_organizations

  has_many :learn_mod_skills, dependent: :destroy
  has_many :global_skills, through: :learn_mod_skills

  has_many :learn_mod_intro_docs, dependent: :destroy
  has_many :global_resources, through: :learn_mod_intro_docs

  has_many :learning_objects

  enum status: [:drafted, :deleted, :published]

  has_one_attached :photo

  validates :name, :time_to_complete, :world_id, presence: true
  validates_uniqueness_of :unique_code
  validates_uniqueness_of :name, case_sensitive: false

  accepts_nested_attributes_for :learn_mod_organizations, allow_destroy: true
  accepts_nested_attributes_for :learn_mod_skills, allow_destroy: true
  accepts_nested_attributes_for :learn_mod_intro_docs, allow_destroy: true

  before_create :set_uniq_token
  before_save :set_cached_skill_list

  # Used for searching LearnMod
  def self.search(keyword)
    where("name ilike :search or description ilike :search or unique_code =
           :code_search or cached_skill_list ilike :search", search:
           "%#{keyword}%", code_search: keyword.delete('^0-9').to_i)
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
end
