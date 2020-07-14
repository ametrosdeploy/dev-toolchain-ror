class AddChatCharacterIdToChatLearnObjs < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_learn_objs, :chat_character_id, :integer
  end
end
