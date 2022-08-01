class FixColumnName < ActiveRecord::Migration[7.0]
  def up
    remove_column :transactions, :type
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end

  def down 
    add_column :transactions, :action, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
