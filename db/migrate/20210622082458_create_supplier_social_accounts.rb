class CreateSupplierSocialAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_social_accounts do |t|
      t.references :supplier,       foreign_key: true, index: true
      t.references :social_account, foreign_key: true, index: true

      t.text :link

      t.timestamps
    end
  end
end
