class AddHaveFollowUpQuestionToDialogicAssmntItem < ActiveRecord::Migration[6.0]
  def change
    add_column :dialogic_assmnt_items, :have_follow_up_question, :boolean, default: false
  end
end
