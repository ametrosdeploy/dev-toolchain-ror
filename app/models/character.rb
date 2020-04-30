class Character < ApplicationRecord
  PER_PAGE = 10
  has_one_attached :photo
  enum gender: %i[male female other]

  def full_name
    "#{first_name} #{last_name}".strip
  end

  # Needed for displaying age on admin panel characters list
  def formatted_age
    "#{age} yrs"
  end
end
