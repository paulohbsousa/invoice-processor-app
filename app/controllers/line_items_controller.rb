class LineItemsController < ApplicationController
  before_action :set_invoice, only: [:new, :create, :destroy]
  def new
    @line_item = LineItem.new
  end

  def create
    @line_item = LineItem.new(line_items_params)
    @invoice.line_items << @line_item
    if @line_item.valid?
      @invoice.save!
    else
      respond_to do |format|
        format.turbo_stream { render "errors/index", status: :unprocessable_entity, locals: { message: @line_item.errors.full_messages } }
      end
    end
  end

  def destroy
    @line_item = @invoice.line_items.find(params[:id])
    @line_item.destroy
  end

  private

  def set_invoice
    @invoice ||= Invoice.find(params[:invoice_id])
  end

  def line_items_params
    params.require(:line_item).permit!
  end
end