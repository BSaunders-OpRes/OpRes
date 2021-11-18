class CreateReleaseNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :release_notes do |t|
      t.integer :title, default: 0
      t.text :note
      t.integer :release_id, foreign_key: true

      t.timestamps
    end
  end
end
