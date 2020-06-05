class AsstEntity < ApplicationRecord
  belongs_to :entity_addable, polymorphic: true
end
