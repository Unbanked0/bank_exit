class AddLatitudeLongitudeToMerchants < ActiveRecord::Migration[8.0]
  def change
    add_column :merchants, :latitude, :float
    add_column :merchants, :longitude, :float
  end
end
