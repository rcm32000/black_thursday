require 'csv'
require_relative 'transaction'
require_relative 'repository'

# This class is a repo for transactions
class TransactionRepository
  include Repository
  def initialize
    @elements = {}
    @invoice_ids = Hash.new{ |h, k| h[k] = [] }
    @results = Hash.new{ |h, k| h[k] = [] }

  end

  def build_elements_hash(attributes_list)
    attributes_list.each do |attributes|
      generate_transaction(attributes)
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.find_all do |element|
      element.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @results[result]
  end

  def create(attributes)
    create_id_number
    attributes[:id] = create_id_number
    generate_transaction(attributes)
  end

  def generate_transaction(attributes)
    transaction = Transaction.new(attributes)
    @elements[transaction.id] = transaction
    @invoice_ids[transaction.invoice_id] << transaction
    @results[transaction.result] << transaction
  end

  def delete(id)
    transaction = find_by_id(id)
    return nil unless transaction
    @invoice_ids.delete(transaction.invoice_id)
    @results.delete(transaction.result)
    super(id)
  end
end
