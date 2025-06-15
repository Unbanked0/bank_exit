class AddCommentsCountToMerchant < ActiveRecord::Migration[8.0]
  def change
    add_column :merchants, :comments_count, :integer, null: false, default: 0
  end
end
