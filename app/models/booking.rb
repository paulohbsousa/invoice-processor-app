class Booking < ApplicationRecord
  has_one :invoice # Can be has_many... depends on the use case (If we want to invoice not only the hotel/flight but something else)
end