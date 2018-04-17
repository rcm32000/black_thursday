require 'csv'
require_relative 'invoice_item'
require_relative 'repository'

# This class is a repo for invoice_items
class InvoiceItemRepository
  include Repository
  def initialize
    @elements = {}
    @invoice_ids = Hash.new{ |h, k| h[k] = [] }
    @item_ids = Hash.new{ |h, k| h[k] = [] }
  end

  def build_elements_hash(attributes_list)
    attributes_list.each do |attributes|
      generate_invoice_item(attributes)
    end
  end

  def find_all_by_item_id(item_id)
    @item_ids[item_id]
  end

  def create(attributes)
    create_id_number
    attributes[:id] = create_id_number
    generate_invoice_item(attributes)
  end

  def generate_invoice_item(attributes)
    invoice_item = InvoiceItem.new(attributes)
    @elements[invoice_item.id] = invoice_item
    @invoice_ids[invoice_item.invoice_id] << invoice_item
    @item_ids[invoice_item.item_id] << invoice_item
  end

  def delete(id)
    invoice_item = find_by_id(id)
    @invoice_ids.delete(invoice_item.invoice_id)
    @item_ids.delete(invoice_item.item_id)
    super(id)
  end
end
