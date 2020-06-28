class RemoveKeyTopicValueIdFromRequiredKeyTopicValue < ActiveRecord::Migration[6.0]
  def change
    remove_reference :required_key_topic_values, :key_topic_value, null: false, foreign_key: true
    add_column :required_key_topic_values, :key_topic_value_id, :integer
  end
end
