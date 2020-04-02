class CreateGlobalVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :global_videos do |t|
      t.text :title
      t.text :description
      t.text :wistia_code
      t.integer :duration
      t.integer :video_type
      t.boolean :private
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
