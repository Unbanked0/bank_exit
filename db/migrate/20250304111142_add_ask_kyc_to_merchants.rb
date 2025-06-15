class AddAskKycToMerchants < ActiveRecord::Migration[8.0]
  def change
    add_column :merchants, :ask_kyc, :boolean, null: false, default: false
  end
end
