class CreateNluKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :nlu_keywords do |t|
      t.references :learning_object, null: false, foreign_key: true
      t.string :keyword
      t.float :relevance

      t.timestamps
    end
  end
end
