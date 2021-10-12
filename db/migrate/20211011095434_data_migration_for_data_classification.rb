class DataMigrationForDataClassification < ActiveRecord::Migration[6.0]
  def change
    BusinessServiceLine.update_all(data_classification: 3)
  end
end
