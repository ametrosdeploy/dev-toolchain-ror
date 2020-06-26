class CreateMissedAssmntItems < ActiveRecord::Migration[6.0]
  def change
    create_table :missed_assmnt_items do |t|
      t.references :key_topic, null: false, foreign_key: true
      t.boolean :has_follow_up_question

      t.timestamps
    end
  end
end
