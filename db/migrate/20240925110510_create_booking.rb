class CreateBooking < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.string :invoice_from
      t.string :traveller_name
      t.date :checkin_date
      t.date :checkout_date
      t.timestamps
    end
  end
end
