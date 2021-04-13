class CreateRelationshipOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :relationship_owners do |t|
      t.references :supplier, foreign_key: true, index: true

      t.string :name
      t.string :email
      t.string :job_title

      t.timestamps
    end
  end
end
