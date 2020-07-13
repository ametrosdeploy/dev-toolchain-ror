class CreateEmailEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :email_evaluations do |t|
      t.references :user_learn_obj, null: false, foreign_key: true
      t.text :email

      t.timestamps
    end
  end
end
