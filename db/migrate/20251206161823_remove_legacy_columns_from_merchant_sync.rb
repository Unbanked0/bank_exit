class RemoveLegacyColumnsFromMerchantSync < ActiveRecord::Migration[8.1]
  def change
    remove_column :merchant_syncs, :process_logs, :json
    remove_column :merchant_syncs, :payload_nostr, :json
    remove_column :merchant_syncs, :payload_error, :json
  end
end
