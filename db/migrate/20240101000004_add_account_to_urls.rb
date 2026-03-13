class AddAccountToUrls < ActiveRecord::Migration[7.1]
  def change
    add_column :urls, :account_id, :integer
  end
end
