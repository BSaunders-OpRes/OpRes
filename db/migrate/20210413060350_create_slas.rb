class CreateSlas < ActiveRecord::Migration[6.0]
  def change
    create_table :slas do |t|
      t.references :slaable, polymorphic: true

      t.float      :service_level_agreement
      t.float      :service_level_objective
      t.integer    :recovery_point_objective
      t.integer    :severity1_response_time
      t.integer    :severity2_response_time
      t.integer    :severity3_response_time
      t.integer    :severity4_response_time
      t.integer    :severity1_restoration_service_time
      t.integer    :severity2_restoration_service_time
      t.integer    :severity3_restoration_service_time
      t.integer    :severity4_restoration_service_time
      t.integer    :support_hours

      t.timestamps
    end
  end
end