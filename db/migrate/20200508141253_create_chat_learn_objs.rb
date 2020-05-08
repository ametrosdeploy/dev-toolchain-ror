class CreateChatLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_learn_objs do |t|
      t.text :administrative_notes
      t.integer :chat_character_id
      t.integer :mentor_character_id

      t.timestamps
    end
  end
end
