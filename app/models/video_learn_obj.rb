class VideoLearnObj < ApplicationRecord
  belongs_to :global_video
  has_one :learning_object, as: :objectable
  has_one :learn_mod, through: :learning_objects
end
