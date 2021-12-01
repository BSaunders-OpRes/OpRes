class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :required_until
      t.integer :importance
      t.integer :RAG, default: 0
      t.integer :rules, default: 0

      t.timestamps
    end
  end
end
