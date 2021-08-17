class AddPasswordToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :password_digest, :string, default: 'test_password_123'
  end
end
