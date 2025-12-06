class RemoveLegacyColumnsFromDirectories < ActiveRecord::Migration[8.1]
  def change
    remove_column :directories, :name_legacy, :string
    remove_column :directories, :description_legacy, :text
  end
end
