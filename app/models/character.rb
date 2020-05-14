# == Schema Information
#
# Table name: characters
#
#  id                  :bigint           not null, primary key
#  first_name          :string           not null
#  last_name           :string
#  age                 :integer
#  gender              :integer
#  real_world          :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  organizations_count :integer          default(0)
#
class Character < ApplicationRecord
  PER_PAGE = 10
  strip_attributes

  has_one_attached :photo
  enum gender: %i[male female other]

  has_many :organization_characters, dependent: :destroy
  has_many :organizations, through: :organization_characters, dependent: :destroy

  has_many :world_org_characters
  has_many :world_organizations, through: :world_org_characters

  has_one_attached :photo

  validates :first_name, :age, presence: true
  validates :gender, inclusion: { in: genders.keys }
  validates :age, numericality: { only_integer: true }

  def full_name
    "#{first_name} #{last_name}".strip
  end

  # Needed for displaying age on admin panel characters list
  def formatted_age
    "#{age} yrs"
  end

  # Used for searching characters
  def self.search(keyword)
    where("concat(first_name,' ',last_name) ilike ?", "%#{keyword}%")
  end
end
