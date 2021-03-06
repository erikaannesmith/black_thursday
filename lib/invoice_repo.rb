require 'csv'
require_relative 'invoice'

class InvoiceRepo

  attr_reader :invoices, :parent

  def initialize(file,se=nil)
    open_file(file)
    @parent = se
  end

  def open_file(file)
    csv = CSV.foreach file,
    headers: true, header_converters: :symbol
    @invoices = csv.map do |row|
      Invoice.new(row, self)
    end
  end

  def all
    invoices
  end

  def find_by_id(id_invoice)
    invoices.find { |invoice| invoice.id == id_invoice }
  end

  def find_all_by_customer_id(customer_id_invoice)
    invoices.find_all { |invoice| invoice.customer_id == customer_id_invoice }
  end

  def find_all_by_merchant_id(merchant_id_invoice)
    invoices.find_all { |invoice| invoice.merchant_id == merchant_id_invoice }
  end

  def find_all_by_status(status_of_invoice)
    invoices.find_all { |invoice| invoice.status == status_of_invoice }
  end

  def invoice_merchant(id)
    parent.invoice_merchant(id)
  end

  def invoice_items_list(id)
    parent.invoice_items_list(id)
  end

  def invoice_transactions(id)
    parent.invoice_transactions(id)
  end

  def invoice_customer(id)
    parent.invoice_customer(id)
  end

  def total(id)
    parent.total(id)
  end

  def invoice_items_for_invoice(id)
    parent.invoice_items_for_invoice(id)
  end

end
