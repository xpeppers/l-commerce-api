class AddResourceToImages < ActiveRecord::Migration
  def change
    add_column :images, :resource, :string
  end
end
