class AddInvitedStatusInUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :invited_status, :boolean, :default => false
  end
end
