# frozen_string_literal: true

class WorldVideo < ApplicationRecord
  belongs_to :global_video
  belongs_to :world
end
