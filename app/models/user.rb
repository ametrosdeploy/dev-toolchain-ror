class User < ApplicationRecord
  rolify
  has_one_attached :photo
end
