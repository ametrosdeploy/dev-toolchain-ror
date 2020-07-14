class CreateUserSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :user_submissions do |t|
      t.references :user_learn_obj, null: false, foreign_key: true
      t.text :user_text

      t.timestamps
    end
  end
end
