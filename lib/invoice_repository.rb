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

  def build_elements_hash(elements)
    elements.each do |element|
      invoice = Invoice.new(element)
      @elements[invoice.id] = invoice
      @merchant_ids[invoice.merchant_id] << invoice
      @customer_ids[invoice.customer_id] << invoice
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
    invoice = Invoice.new(attributes)
    @elements[create_id_number] = invoice
  end

  def update(id, attributes)
    super(id, attributes)
    attribute = attributes[:merchant_id]
    @elements[id].attributes[:merchant_id] = attribute if attribute
  end
end
