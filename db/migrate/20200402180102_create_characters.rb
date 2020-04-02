class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :first_name
      t.string :last_name
      t.string :age
      t.string :gender
      t.string :real_world

      t.timestamps
    end
  end
end
