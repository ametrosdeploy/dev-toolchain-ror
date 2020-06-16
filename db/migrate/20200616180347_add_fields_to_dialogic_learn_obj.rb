class AddFieldsToDialogicLearnObj < ActiveRecord::Migration[6.0]
  def change
    add_column :dialogic_learn_objs, :introduction, :text
    add_column :dialogic_learn_objs, :conclusion, :text
  end
end
