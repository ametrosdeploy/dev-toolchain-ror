# frozen_string_literal: true

class CreateGlobalVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :global_videos do |t|
      t.string :title
      t.text :description
      t.string :wistia_code
      t.integer :duration
      t.integer :video_type
      t.boolean :private, default: false
      t.text :transcript
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
