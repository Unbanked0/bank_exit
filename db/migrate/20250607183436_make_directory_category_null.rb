class MakeDirectoryCategoryNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :directories, :category, true
  end
end
