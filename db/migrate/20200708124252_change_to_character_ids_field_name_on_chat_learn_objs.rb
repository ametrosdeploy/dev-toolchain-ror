class ChangeToCharacterIdsFieldNameOnChatLearnObjs < ActiveRecord::Migration[6.0]
  def change
    rename_column :chat_learn_objs, :chat_character_id, :chat_character_id, array: false
  end
end
