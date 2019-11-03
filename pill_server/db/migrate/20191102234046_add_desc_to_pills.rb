class AddDescToPills < ActiveRecord::Migration[5.2]
  def change
    add_column :pills, :desc, :string
  end
end
