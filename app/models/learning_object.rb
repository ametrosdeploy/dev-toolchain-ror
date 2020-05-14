class LearningObject < ApplicationRecord
  belongs_to :learn_mod, counter_cache: :learning_objects_count
  belongs_to :objectable
end
