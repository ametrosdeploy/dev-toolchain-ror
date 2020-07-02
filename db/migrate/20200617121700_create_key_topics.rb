class CreateKeyTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :key_topics do |t|
      t.references :dialogic_question, null: false, foreign_key: true

      t.timestamps
    end

    create_table :key_topic_values do |t| 
      t.references :key_topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
