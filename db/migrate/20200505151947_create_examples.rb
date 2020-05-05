class CreateExamples < ActiveRecord::Migration[6.0]
  def change
    create_table :examples do |t|
      t.text :body
      t.string :data

      t.timestamps
    end
  end
end
