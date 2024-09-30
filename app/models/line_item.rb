class LineItem < ActiveRecord::Base
  belongs_to :invoice

  validates :traveller_name, presence: true
  validates :start_date,
            comparison: { less_than_or_equal_to: :end_date }
  validates :end_date,
            comparison: { greater_than_or_equal_to: :start_date }
  validates :category, presence: true
  validates :quantity, presence: true, :numericality => { :greater_than_or_equal_to => 1 }
  validates :currency, presence: true, inclusion: { in: %w[EUR USD] }
  validates :unit_price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :vat_rate, presence: true, inclusion: { in: [7, 19] }

  enum category: {
    one: "One",
    two: "Two",
    three: "Three",
    four: "Four",
    five: "Five",
  }

  def self.categories_as_option
    LineItem.categories.map{ |index, category| OpenStruct.new(name: category , id: index) }
  end

  def amount
    ((self.unit_price || 0) * self.quantity.to_f)
  end
end