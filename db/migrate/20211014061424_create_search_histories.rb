class CreateSearchHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :search_histories do |t|
      t.string     :title
      t.text       :url
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
