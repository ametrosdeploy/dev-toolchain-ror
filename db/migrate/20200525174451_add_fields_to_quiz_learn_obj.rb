class AddFieldsToQuizLearnObj < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_learn_objs, :title, :string
    add_column :quiz_learn_objs, :description, :text
    add_column :quiz_learn_objs, :score_view_type, :int
  end
end
