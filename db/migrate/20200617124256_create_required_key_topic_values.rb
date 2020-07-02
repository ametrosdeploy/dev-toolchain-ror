class CreateRequiredKeyTopicValues < ActiveRecord::Migration[6.0]
  def change
    create_table :required_key_topic_values do |t|
      t.references :dialogic_assmnt_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
