class AddOccupiableToInterstitialContent < ActiveRecord::Migration[6.0]
  def change
    add_reference :interstitial_contents, :occupiable, polymorphic: true, null: false, index: { name: :occupiable_index }
  end
end
