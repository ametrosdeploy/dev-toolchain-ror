class CreateTestEmailEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :test_email_evaluations do |t|
      t.string :keyword_list, array: true, default: []
      t.string :concept_list, array: true, default: []
      t.string :nlu_entities_list, array: true, default: []
      t.float :joy_score
      t.float :anger_score
      t.float :disgust_score
      t.float :sadness_score
      t.float :fear_score
      t.string :asst_intent_list, array: true, default: []
      t.integer :asst_entity_value_list, array: true, default: []
      t.string :sentiment
      t.float :sentiment_score
      t.references :user, null: false, foreign_key: true
      t.references :email_learn_obj, null: false, foreign_key: true

      t.timestamps
    end
  end
end
