class RenamePasswordInUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :password, :encrypted_password
  end
end
