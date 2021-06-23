class ChangeSla < ActiveRecord::Migration[6.0]
  def change
    rename_column :slas, :severity1_response_time, :severity1
    rename_column :slas, :severity2_response_time, :severity2
    rename_column :slas, :severity3_response_time, :severity3
    rename_column :slas, :severity4_response_time, :severity4

    rename_column :slas, :severity1_restoration_service_time, :severity1_restoration
    rename_column :slas, :severity2_restoration_service_time, :severity2_restoration
    rename_column :slas, :severity3_restoration_service_time, :severity3_restoration
    rename_column :slas, :severity4_restoration_service_time, :severity4_restoration

    add_column :slas, :support_hours_other, :string
  end
end
