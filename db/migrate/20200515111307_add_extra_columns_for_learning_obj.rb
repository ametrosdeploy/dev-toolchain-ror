class AddExtraColumnsForLearningObj < ActiveRecord::Migration[6.0]
  def change
    add_column :email_learn_objs, :title, :string
    add_column  :email_learn_objs, :description, :text
    add_column :email_learn_objs, :to_character_ids, :integer, array: true, default: []
    add_column :email_learn_objs, :cc_character_ids, :integer, array: true, default: []
    add_column :video_learn_objs, :title, :string
    add_column :video_learn_objs, :description, :text
    add_column :text_learn_objs, :title, :string
    add_column :text_learn_objs, :description, :text
    add_column :learn_mods, :status, :integer, default: 0
    add_column :learning_objects, :status, :integer, default: 0
  end
end
