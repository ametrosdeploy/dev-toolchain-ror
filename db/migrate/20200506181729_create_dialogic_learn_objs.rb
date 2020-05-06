class CreateDialogicLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :dialogic_learn_objs do |t|

      t.timestamps
    end
  end
end
