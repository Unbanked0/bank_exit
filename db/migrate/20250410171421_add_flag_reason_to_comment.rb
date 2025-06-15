class AddFlagReasonToComment < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :flag_reason, :integer
  end
end
