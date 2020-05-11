class CreateEmailInteractions < ActiveRecord::Migration[6.0]
  def change
    create_table :email_interactions do |t|
      t.integer :card_order
      t.bigint :next_chain_id
      t.string :name

      t.timestamps
    end
  end
end
