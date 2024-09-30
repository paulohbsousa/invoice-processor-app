class Invoice < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_one_attached :document
  belongs_to :booking, optional: true

  before_create :set_draft

  validates :tax_number, presence: true, valvat: true, if: :is_finished?
  validates :company_name, presence: true, if: :is_finished?
  validates :invoice_date, presence: true, if: :is_finished?
  validates :invoice_date,
            comparison: { less_than_or_equal_to: Date.today },
            allow_blank: true,
            if: :is_finished?
  validates :invoice_number, presence: true, numericality: { only_integer: true }, if: :is_finished?
  validates :street_name, presence: true, if: :is_finished?
  validates :street_number, presence: true, numericality: { only_integer: true }, if: :is_finished?
  validates :postal_code, presence: true, numericality: { only_integer: true }, if: :is_finished?
  validates :city, presence: true, if: :is_finished?
  validates :line_items, :length => { :minimum => 1 }, if: :is_finished?

  def set_draft
    self.status = "draft"
  end

  def totals
    totals = {
      subtotal: 0,
      vat7_total: 0,
      vat7: 0,
      vat19_total: 0,
      vat19: 0,
      total: 0
    }
    self.line_items.each do |line_item|
      totals[:subtotal] += line_item.amount
      totals[:vat7] += line_item.amount if line_item.vat_rate == 7
      totals[:vat19] += line_item.amount if line_item.vat_rate == 19
    end
    totals[:vat7_total] = (totals[:vat7] * 0.07).round(2) if totals[:vat7] > 0
    totals[:vat19_total] = (totals[:vat19] * 0.19).round(2) if totals[:vat19] > 0
    totals[:total] = totals[:subtotal] + totals[:vat7_total] + totals[:vat19_total]
    totals
  end

  enum status: {
    draft: "draft",
    finished: "finished"
  }

  private

  def is_finished?
    !new_record? && self.status == "finished"
  end

end