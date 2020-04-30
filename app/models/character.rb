class Character < ApplicationRecord
  has_one_attached :photo
  enum gender: %i[male female other]

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def formatted_age
    "#{age} yrs"
  end
end
