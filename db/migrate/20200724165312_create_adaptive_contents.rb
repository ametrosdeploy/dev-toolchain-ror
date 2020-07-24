class CreateAdaptiveContents < ActiveRecord::Migration[6.0]
  def change
    create_table :adaptive_contents do |t|
      t.string :title
      t.text :description
      t.references :adaptable, polymorphic: true, null: false
      t.references :contentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
