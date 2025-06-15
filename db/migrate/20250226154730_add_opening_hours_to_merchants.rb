class AddOpeningHoursToMerchants < ActiveRecord::Migration[8.0]
  def change
    add_column :merchants, :opening_hours, :string
  end
end
