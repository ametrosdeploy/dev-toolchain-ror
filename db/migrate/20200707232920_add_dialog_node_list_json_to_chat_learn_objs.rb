class AddDialogNodeListJsonToChatLearnObjs < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_learn_objs, :dialog_node_list, :json
  end
end
