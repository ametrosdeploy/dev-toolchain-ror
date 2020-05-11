class CreateFileLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :file_learn_objs do |t|

      t.timestamps
    end
  end
end
