class CreateEntityEvaluationItems < ActiveRecord::Migration[6.0]
  def change
    create_table :entity_evaluation_items do |t|
      t.references :entity_evaluation, null: false, foreign_key: true
      t.references :asst_entity_value, null: false, foreign_key: true

      t.timestamps
    end
  end
end
