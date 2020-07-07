class CreateResponseFormulas < ActiveRecord::Migration[6.0]
  def change
    create_table :response_formulas do |t|
      t.string :formula
      t.integer :keywords_minimum, default: 0

      t.timestamps
    end
  end
end
