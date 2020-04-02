class VideoLearnObj < ApplicationRecord
    belongs_to :global_video
    has_one :learning_object, as: :objectable
end
