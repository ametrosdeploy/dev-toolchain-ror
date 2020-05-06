class CreateEmailLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :email_learn_objs do |t|

      t.timestamps
    end
  end
end
