class RemoveSupplierIdFromSupplierSocialAccount < ActiveRecord::Migration[6.0]
  def change
    remove_column :supplier_social_accounts,  :supplier_id
    rename_table  :supplier_social_accounts,  :social_account_recipients
    add_reference :social_account_recipients, :social_account_recipientable, polymorphic: true, index: { name: 'sar_social_account_id' }
  end
end

