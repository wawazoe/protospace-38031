class RenameTextColumnToContent < ActiveRecord::Migration[6.0]
  def change
      rename_column :comments, :text, :content
  end
end
