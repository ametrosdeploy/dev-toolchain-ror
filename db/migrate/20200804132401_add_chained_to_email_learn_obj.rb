class AddChainedToEmailLearnObj < ActiveRecord::Migration[6.0]
  def change
    add_column :email_learn_objs, :chained_to, :integer
  end
end
