class Addfieldstofinish < ActiveRecord::Migration
  def change
  	add_column :orders, :email, :string
  	add_column :orders, :name, :string
  end
end
