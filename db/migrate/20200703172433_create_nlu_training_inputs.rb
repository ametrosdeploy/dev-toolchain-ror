class CreateNluTrainingInputs < ActiveRecord::Migration[6.0]
  def change
    create_table :nlu_training_inputs do |t|
      t.text :message
      t.references :email_learn_obj, null: false, foreign_key: true

      t.timestamps
    end
  end
end
