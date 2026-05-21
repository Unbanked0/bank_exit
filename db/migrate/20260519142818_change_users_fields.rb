class ChangeUsersFields < ActiveRecord::Migration[8.1]
  def change
    rename_column :users, :email, :email_address
    add_column :users, :password_digest, :string
  end
end
