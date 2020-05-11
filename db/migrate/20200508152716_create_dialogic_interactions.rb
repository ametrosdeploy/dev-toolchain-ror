class CreateDialogicInteractions < ActiveRecord::Migration[6.0]
  def change
    create_table :dialogic_interactions do |t|
      t.string :name
      t.integer :card_order

      t.timestamps
    end
  end
end
