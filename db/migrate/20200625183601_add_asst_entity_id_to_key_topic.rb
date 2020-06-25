class AddAsstEntityIdToKeyTopic < ActiveRecord::Migration[6.0]
  def change
    add_reference :key_topics, :asst_entity, null: false, foreign_key: true
  end
end
