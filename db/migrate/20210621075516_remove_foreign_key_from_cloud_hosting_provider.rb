class RemoveForeignKeyFromCloudHostingProvider < ActiveRecord::Migration[6.0]
  def change
    remove_reference :cloud_hosting_providers, :supplier, index: true, foreign_key: true

    add_column       :suppliers, :start_date, :date
    add_column       :suppliers, :end_date,   :date

    add_column       :slas, :recovery_time_objective, :integer
  end
end
