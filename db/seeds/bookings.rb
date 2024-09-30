class Bookings
  def self.bookings
    [
      {invoice_from: "Hotel One", traveller_name: "Paulo Sousa", checkin_date: "2024-08-10", checkout_date: "2024-08-12"},
      {invoice_from: "Hotel Two", traveller_name: "John Doe", checkin_date: "2024-08-10", checkout_date: "2024-09-12"},
      {invoice_from: "Hotel One", traveller_name: "Paulo Sousa", checkin_date: "2024-09-10", checkout_date: "2024-09-12"},
      {invoice_from: "Hotel Three", traveller_name: "Alina S", checkin_date: "2024-08-10", checkout_date: "2024-08-12"},
      {invoice_from: "Hotel One", traveller_name: "Paulo Sousa", checkin_date: "2024-08-10", checkout_date: "2024-08-12"},
      {invoice_from: "Hotel Two", traveller_name: "John Doe", checkin_date: "2024-08-10", checkout_date: "2024-08-12"},
      {invoice_from: "Hotel Five", traveller_name: "Alina S", checkin_date: "2024-08-10", checkout_date: "2024-08-12"},
      {invoice_from: "Hotel Four", traveller_name: "John Doe", checkin_date: "2024-08-10", checkout_date: "2024-08-12"},
      {invoice_from: "Hotel One", traveller_name: "Paulo Sousa", checkin_date: "2024-08-10", checkout_date: "2024-08-12"},
      {invoice_from: "Hotel Six", traveller_name: "Paulo Sousa", checkin_date: "2024-08-10", checkout_date: "2024-08-12"},
      {invoice_from: "Hotel Seven", traveller_name: "Paulo Sousa", checkin_date: "2024-08-10", checkout_date: "2024-08-12"},
      {invoice_from: "Hotel One", traveller_name: "Paulo Sousa", checkin_date: "2024-08-10", checkout_date: "2024-08-12"},
      {invoice_from: "Hotel Nine", traveller_name: "Paulo Sousa", checkin_date: "2024-08-10", checkout_date: "2024-08-12"},
      {invoice_from: "Hotel One", traveller_name: "Paulo Sousa", checkin_date: "2024-08-10", checkout_date: "2024-08-12"},
    ]
  end

  def self.load
    bookings.each do |booking|
      Booking.create!(
        invoice_from: booking[:invoice_from],
        traveller_name: booking[:traveller_name],
        checkin_date: booking[:checkin_date],
        checkout_date: booking[:checkout_date]
      )
    end
    true
  end
end
