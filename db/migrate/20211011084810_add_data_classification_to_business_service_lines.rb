class AddDataClassificationToBusinessServiceLines < ActiveRecord::Migration[6.0]
  def change
    add_column :business_service_lines, :data_classification, :integer
  end
end
