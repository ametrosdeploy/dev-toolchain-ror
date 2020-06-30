class CreateMissedResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :missed_responses do |t|
      t.references :missed_assmnt_item, null: false, foreign_key: true
      t.text :response
      t.boolean :follow_up, default: false

      t.timestamps
    end
  end
end
