class AddContactOdyseeToMerchant < ActiveRecord::Migration[8.0]
  def change
    add_column :merchants, :contact_odysee, :string
  end
end
