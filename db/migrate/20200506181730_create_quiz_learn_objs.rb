class CreateQuizLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_learn_objs do |t|

      t.timestamps
    end
  end
end
