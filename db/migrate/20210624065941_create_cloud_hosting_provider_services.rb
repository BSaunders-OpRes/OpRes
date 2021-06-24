class CreateCloudHostingProviderServices < ActiveRecord::Migration[6.0]
  def change
    create_table :cloud_hosting_provider_services do |t|
      t.references :cloud_hosting_provider, foreign_key: true, index: { name: 'chps_on_chp_id' }

      t.string :name
      t.timestamps
    end
  end
end
