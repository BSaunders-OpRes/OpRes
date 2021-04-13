class CreateKeyContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :key_contacts do |t|
      t.references :unit, foreign_key: true, index: true

      t.string :name
      t.string :email
      t.string :job_title

      t.timestamps
    end
  end
end
