class Customer < ApplicationRecord
    has_many :private_worlds, class_name: 'World'
end
