class CreateVulnerabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :vulnerabilities do |t|
      t.references :business_service_line, foreign_key: true, index: true

      t.string  :type
      t.integer :time_in_seconds

      t.timestamps
    end
  end
end
