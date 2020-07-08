class ChangeToCharacterIdsFieldNameOnChatLearnObjs < ActiveRecord::Migration[6.0]
  def change
    rename_column :chat_learn_objs, :to_character_ids, :chat_character_id
  end
end
