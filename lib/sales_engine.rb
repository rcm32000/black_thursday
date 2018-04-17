require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'sales_analyst'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
# Ties together DAL
class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(attrs)
    @items = ItemRepository.new
    @items.from_csv(attrs[:items]) if attrs[:items]
    @merchants = MerchantRepository.new
    @merchants.from_csv(attrs[:merchants]) if attrs[:merchants]
    @invoices = InvoiceRepository.new
    @invoices.from_csv(attrs[:invoices]) if attrs[:invoices]
    @invoice_items = InvoiceItemRepository.new
    @invoice_items.from_csv(attrs[:invoice_items]) if attrs[:invoice_items]
    @transactions = TransactionRepository.new
    @transactions.from_csv(attrs[:transactions]) if attrs[:transactions]
    @customers = CustomerRepository.new
    @customers.from_csv(attrs[:customers]) if attrs[:customers]
  end

  def self.from_csv(attributes)
    SalesEngine.new(attributes)
  end

  def analyst
    @analyst ||= SalesAnalyst.new(self)
  end
end
