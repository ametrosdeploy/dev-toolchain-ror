class AddFieldsToChatLearnObjs < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_learn_objs, :title, :string
    add_column :chat_learn_objs, :to_character_ids, :integer, array: true
    add_column :chat_learn_objs, :mentor_character_id, :integer
  end
end
