class AddDeletedAtToMerchant < ActiveRecord::Migration[8.0]
  def change
    add_column :merchants, :deleted_at, :datetime
  end
end
