class CreateBusinessServiceLineChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :business_service_line_channels do |t|
      t.references :business_service_line, foreign_key: true, index: { name: 'bsl_channels_on_bsl_id' }
      t.references :channel,               foreign_key: true, index: { name: 'bsl_channels_on_channel_id' }

      t.timestamps
    end
  end
end
