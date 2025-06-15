class CreateCoinWallets < ActiveRecord::Migration[8.0]
  def change
    create_table :coin_wallets do |t|
      t.integer :coin
      t.string :public_address
      t.boolean :enabled, null: false, default: true
      t.references :walletable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
