class CreateInstitutions < ActiveRecord::Migration[6.0]
  def change
    create_table :institutions do |t|
      t.string  :name
      t.text    :description
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
