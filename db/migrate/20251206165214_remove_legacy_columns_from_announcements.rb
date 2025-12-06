class RemoveLegacyColumnsFromAnnouncements < ActiveRecord::Migration[8.1]
  def change
    remove_column :announcements, :title, :string
    remove_column :announcements, :description, :text
    remove_column :announcements, :link_to_visit, :string
  end
end
