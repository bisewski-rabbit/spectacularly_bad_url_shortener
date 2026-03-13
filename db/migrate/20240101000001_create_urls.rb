class CreateUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :short_code
      t.integer :click_count
      t.string :created_by_ip
      t.timestamps
    end
  end
end

