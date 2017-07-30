class AddEmailUniquenessIndex < ActiveRecord::Migration[5.1]
  def self.up
    add_index :users, :email, unique: true
  end
end
