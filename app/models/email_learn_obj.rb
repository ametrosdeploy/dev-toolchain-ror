class EmailLearnObj < ApplicationRecord
    has_one :learning_object, as: :objectable
end
