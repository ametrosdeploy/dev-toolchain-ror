class CreateLearnMods < ActiveRecord::Migration[6.0]
  def change
    create_table :learn_mods do |t|
      t.string :name
      t.integer :time_to_complete
      t.text :abstract
      t.references :world, null: false, foreign_key: true
      t.integer :intro_video_id

      t.timestamps
    end
  end
end
