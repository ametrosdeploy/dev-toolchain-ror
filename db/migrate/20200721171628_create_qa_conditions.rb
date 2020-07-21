class CreateQaConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :qa_conditions do |t|
      t.references :email_learn_obj, null: false, foreign_key: true
      t.integer :character_id
      t.text :ooto_response

      t.timestamps
    end
  end
end
