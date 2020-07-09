class AddCharacterStartsInteractionToUserChats < ActiveRecord::Migration[6.0]
  def change
    add_column :user_chats, :character_starts_interaction, :boolean, default: false, null: false
  end
end
