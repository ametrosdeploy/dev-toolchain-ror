class CreateTextLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :text_learn_objs do |t|
      t.timestamps
    end
  end
end
