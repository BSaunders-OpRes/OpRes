class RemoveForeignKeyFromCloudHostingProvider < ActiveRecord::Migration[6.0]
  def change
    remove_reference :cloud_hosting_providers, :supplier, index: true, foreign_key: true
    add_column       :suppliers, :start_date, :date
    add_column       :suppliers, :end_date,   :date
    add_column       :supplier_contacts, :job_title, :string
    add_reference    :supplier_contacts, :supplier, index: true, foreign_key: true
    remove_reference :supplier_contacts, :unit, index: true, foreign_key: true
    add_column       :slas, :recovery_time_objective, :integer
  end
end
