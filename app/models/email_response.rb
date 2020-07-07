# == Schema Information
#
# Table name: email_responses
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class EmailResponse < ApplicationRecord
  # Associations ...
  has_many :character_responses
end
