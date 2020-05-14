class CreateTechnicalLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :technical_learn_objs do |t|
      t.timestamps
    end
  end
end
