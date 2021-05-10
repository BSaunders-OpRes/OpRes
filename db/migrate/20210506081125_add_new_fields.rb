class AddNewFields < ActiveRecord::Migration[6.0]
  def change
    rename_column :risk_appetites,   :type, :name

    add_column    :pre_institutions, :unit_type, :integer
    add_column    :users,            :job_title, :string
    remove_column :business_service_lines, :region, :string
    remove_column :business_service_lines, :country, :string
    remove_column :business_service_lines, :institution, :string
  end
end
