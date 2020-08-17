class RemoveReferenceFromRequiredKeyTopicValues < ActiveRecord::Migration[6.0]
  def change
    if foreign_key_exists?(:required_key_topic_values, :key_topic_values)
      remove_foreign_key :required_key_topic_values, :key_topic_values
    end
  end
end
