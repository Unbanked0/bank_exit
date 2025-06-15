class AddAdditionalContactInfoToMerchants < ActiveRecord::Migration[8.0]
  def change
    add_column :merchants, :contact_session, :string
    add_column :merchants, :contact_signal, :string
    add_column :merchants, :contact_matrix, :string
    add_column :merchants, :contact_jabber, :string
    add_column :merchants, :contact_telegram, :string
    add_column :merchants, :contact_facebook, :string
    add_column :merchants, :contact_instagram, :string
    add_column :merchants, :contact_twitter, :string
    add_column :merchants, :contact_youtube, :string
    add_column :merchants, :contact_tiktok, :string
    add_column :merchants, :contact_linkedin, :string
    add_column :merchants, :contact_tripadvisor, :string
  end
end
