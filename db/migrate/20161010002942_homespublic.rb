class Homespublic < ActiveRecord::Migration
  def change
    add_column :homes, :is_public, :boolean, default: false
  end
end
