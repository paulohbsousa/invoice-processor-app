class CreateInvoice < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.references :booking, null: true, foreign_key: true
      t.integer :receiving_company_id # This should be a reference in the real world, instead of an int
      t.string :country
      t.string :tax_number
      t.string :company_name
      t.date :invoice_date
      t.string :invoice_number
      t.string :street_name
      t.string :street_number
      t.integer :postal_code
      t.string :city
      t.integer :status
      t.boolean :is_germany_company, default: false, null: false
      t.timestamps
    end
  end
end
