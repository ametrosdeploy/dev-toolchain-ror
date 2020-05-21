# frozen_string_literal: true

class CreateWorldVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :world_videos do |t|
      t.references :global_video, null: false, foreign_key: true
      t.references :world, null: false, foreign_key: true

      t.timestamps
    end
  end
end
