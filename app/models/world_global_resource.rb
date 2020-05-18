# frozen_string_literal: true

class WorldGlobalResource < ApplicationRecord
  belongs_to :global_resource
  belongs_to :world
end
