class AddRoleToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :role, :integer, default: 0
  end
end
