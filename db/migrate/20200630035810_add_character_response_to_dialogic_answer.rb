class AddCharacterResponseToDialogicAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :dialogic_answers, :character_response, :text
    add_column :dialogic_answers, :follow_up_question, :text
  end
end
