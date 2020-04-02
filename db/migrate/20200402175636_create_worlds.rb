class CreateWorlds < ActiveRecord::Migration[6.0]
  def change
    create_table :worlds do |t|
      t.string :name
      t.string :world_code
      t.boolean :private
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
