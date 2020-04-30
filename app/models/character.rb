class Character < ApplicationRecord
  PER_PAGE = 10
  has_one_attached :photo
  enum gender: %i[male female other]

  has_many :organization_characters
  has_many :organizations, through: :organization_characters

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
end
