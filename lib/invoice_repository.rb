require 'csv'
require_relative 'invoice'
require_relative 'repository'

# This class is a repo for invoices
class InvoiceRepository
  include Repository
  def initialize
    @elements = {}
    @merchant_ids = Hash.new{ |h, k| h[k] = [] }
    @customer_ids = Hash.new{ |h, k| h[k] = [] }
  end

  def build_elements_hash(attributes_list)
    attributes_list.each do |attributes|
      generate_invoice(attributes)
    end
  end

  def find_all_by_status(status)
    all.find_all do |element|
      element.status == status.to_sym
    end
  end

  def find_all_by_customer_id(cust_id)
    @customer_ids[cust_id]
  end

  def create(attributes)
    create_id_number
    attributes[:id] = create_id_number
    generate_invoice(attributes)
  end

  def generate_invoice(attributes)
    invoice = Invoice.new(attributes)
    @elements[invoice.id] = invoice
    @merchant_ids[invoice.merchant_id] << invoice
    @customer_ids[invoice.customer_id] << invoice
  end

  def update(id, attributes)
    super(id, attributes)
    attribute = attributes[:merchant_id]
    @elements[id].attributes[:merchant_id] = attribute if attribute
  end

  def delete(id)
    invoice = find_by_id(id)
    return nil unless invoice
    @merchant_ids.delete(invoice.merchant_id)
    @customer_ids.delete(invoice.customer_id)
    super(id)
  end
end
