class CreateChatLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_learn_objs do |t|

      t.timestamps
    end
  end
end
