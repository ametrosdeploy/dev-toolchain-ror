class CreateNluSentiments < ActiveRecord::Migration[6.0]
  def change
    create_table :nlu_sentiments do |t|
      t.references :learning_object, null: false, foreign_key: true
      t.integer :sentiment
      t.float :score

      t.timestamps
    end
  end
end
