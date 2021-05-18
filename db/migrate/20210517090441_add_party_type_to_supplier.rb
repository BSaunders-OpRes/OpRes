class AddPartyTypeToSupplier < ActiveRecord::Migration[6.0]
  def change
    add_column :suppliers, :party_type, :integer
  end
end
