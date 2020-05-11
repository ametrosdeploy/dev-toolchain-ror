class CreateGlobalVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :global_videos do |t|
      t.string :title
      t.text :description
      t.string :wistia_code
      t.integer :duration
      t.integer :video_type
      t.boolean :private
      t.references :customer, null: false, foreign_key: true
      t.text :transcript

      t.timestamps
    end
  end
end
