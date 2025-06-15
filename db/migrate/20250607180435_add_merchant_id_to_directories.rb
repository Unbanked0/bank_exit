class AddMerchantIdToDirectories < ActiveRecord::Migration[8.0]
  def change
    add_reference :directories, :merchant, foreign_key: true
  end
end
