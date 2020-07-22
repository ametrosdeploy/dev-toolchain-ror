class CreateNluSemanticRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :nlu_semantic_roles do |t|
      t.references :learning_object, null: false, foreign_key: true
      t.text :sentence
      t.string :subject
      t.string :action_verb_txt
      t.string :action_verb_tense
      t.string :action_txt
      t.string :action_txt_normalized
      t.string :object

      t.timestamps
    end
  end
end
