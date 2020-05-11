class CreateInterstitialContents < ActiveRecord::Migration[6.0]
  def change
    create_table :interstitial_contents do |t|
      t.references :email_learn_obj, null: false, foreign_key: true
      t.integer :content_order

      t.timestamps
    end
  end
end
