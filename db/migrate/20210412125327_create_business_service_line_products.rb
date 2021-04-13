class CreateBusinessServiceLineProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :business_service_line_products do |t|
    	t.references :business_service_line, foreign_key: true, index: { name: 'bsl_products_on_bsl_id' }
      t.references :product,               foreign_key: true, index: { name: 'bsl_products_on_product_id' }
      
      t.timestamps
    end
  end
end
