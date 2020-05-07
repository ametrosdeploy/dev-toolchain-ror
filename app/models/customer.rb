# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_customers_on_email  (email) UNIQUE
#
class Customer < ApplicationRecord
  PER_PAGE = 10
  has_many :worlds
  validates :name, :email, presence: true

end
