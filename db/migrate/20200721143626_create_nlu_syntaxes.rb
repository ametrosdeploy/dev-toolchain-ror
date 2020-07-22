class CreateNluSyntaxes < ActiveRecord::Migration[6.0]
  def change
    create_table :nlu_syntaxes do |t|
      t.references :learning_object, null: false, foreign_key: true
      t.string :token
      t.string :part_of_speech
      t.string :lemma

      t.timestamps
    end
  end
end
