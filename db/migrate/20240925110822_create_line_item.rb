class CreateLineItem < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.references :invoice, null: false, foreign_key: true
      t.string :traveller_name
      t.date :start_date
      t.date :end_date
      t.string :description
      t.string :category
      t.integer :quantity
      t.string :currency
      t.float :unit_price
      t.integer :vat_rate
      t.timestamps
    end
  end
end
