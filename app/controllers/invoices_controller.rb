class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:edit, :update]

  STEPS = %w[invoices/steps/connect_booking invoices/steps/verify_booking invoices/steps/additional_details]
  def create
    @invoice = Invoice.create!
    @invoice.document.attach(invoices_params[:document])
    redirect_to controller: 'invoices', action: 'edit', id: @invoice.id, step: 1
  end

  def edit
    @document = url_for(@invoice.document)

    get_step_data
  end

  def update
    @step = params[:step].to_i + 1
    begin
      @invoice.booking = Booking.find(params[:booking_id]) if params[:booking_id]
      @invoice.is_germany_company = params[:is_germany_company] == "yes" if params[:step] == "2"
      @invoice.update!(
        tax_number: params[:tax_number],
        company_name: params[:company_name],
        invoice_date: params[:invoice_date],
        invoice_number: params[:invoice_number],
        street_name: params[:street_name],
        street_number: params[:street_number],
        postal_code: params[:postal_code],
        city: params[:city],
        country: params[:country],
        status: Invoice.statuses[:finished],
      ) if params[:step] == "3"
      @invoice.save!
      redirect_to controller: 'invoices', action: 'edit', id: @invoice.id, step: @step
    rescue ActiveRecord::RecordNotFound => _
      respond_to do |format|
        format.turbo_stream { render "errors/index", status: :not_found, locals: { message: "The booking id #{params[:booking_id]} was not found" } }
      end
    rescue ActiveRecord::RecordInvalid => e
      respond_to do |format|
        format.turbo_stream { render "errors/index", status: :unprocessable_entity, locals: { message: e.to_s } }
      end
    end
  end

  private
  def get_step_data
    @step = params[:step].to_i || 1
    case @step
    when 3
      @countries = ISO3166::Country.all.map { |country| OpenStruct.new(name: country.common_name , id: country.alpha2) }
    else
      # do nothing
    end
    @layout = STEPS[@step - 1] || "invoices/steps/empty"
    @last_step = @step > STEPS.length
  end

  def set_invoice
    @invoice ||= Invoice.find(params[:id])
  end

  def invoices_params
    params.require(:invoice)
  end

end