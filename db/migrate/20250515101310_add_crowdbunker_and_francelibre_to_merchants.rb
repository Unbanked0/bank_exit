class AddCrowdbunkerAndFrancelibreToMerchants < ActiveRecord::Migration[8.0]
  def change
    add_column :merchants, :contact_crowdbunker, :string
    add_column :merchants, :contact_francelibretv, :string
  end
end
