class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.integer :age
      t.integer :gender
      t.boolean :real_world

      t.timestamps
    end
  end
end
