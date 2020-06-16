class CreateAsstIntentExamples < ActiveRecord::Migration[6.0]
  def change
    create_table :asst_intent_examples do |t|
      t.text :example
      t.references :asst_intent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
