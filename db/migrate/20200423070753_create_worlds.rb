class CreateWorlds < ActiveRecord::Migration[6.0]
  def change
    create_table :worlds do |t|
      t.string :name
      t.text :description
      t.integer :customer_id
      t.integer :world_code
      t.boolean :is_private
      t.integer :learn_mods_count

      t.timestamps
    end
  end
end
