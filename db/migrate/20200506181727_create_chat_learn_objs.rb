# frozen_string_literal: true

class CreateChatLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_learn_objs, &:timestamps
  end
end
