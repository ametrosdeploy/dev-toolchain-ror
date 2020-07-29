class AddTitleToInterstitialContent < ActiveRecord::Migration[6.0]
  def change
    add_column :interstitial_contents, :title, :string
    add_column :interstitial_contents, :description, :text
  end
end
