class AddAdminCreatorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :creator, :boolean, default: false
  end
end
