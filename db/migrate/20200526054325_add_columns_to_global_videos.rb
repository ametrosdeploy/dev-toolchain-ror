# frozen_string_literal: true

# Add missing migation wistia_thumbnail_url to global_videos
class AddColumnsToGlobalVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :global_videos, :wistia_thumbnail_url, :string
    add_column :global_videos, :file_name, :string
  end
end
