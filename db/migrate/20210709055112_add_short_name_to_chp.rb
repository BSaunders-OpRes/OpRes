class AddShortNameToChp < ActiveRecord::Migration[6.0]
  def change
    add_column :cloud_hosting_providers, :short_name, :string
  end
end
