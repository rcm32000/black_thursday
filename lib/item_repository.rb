require 'csv'
require_relative 'item'
require_relative 'repository'

# This class is a repo for items
class ItemRepository
  include Repository
  def initialize
    @elements = {}
    @merchant_ids = Hash.new{ |h, k| h[k] = [] }
  end

  def build_elements_hash(attributes_list)
    attributes_list.each do |attributes|
      generate_item(attributes)
    end
  end

  def find_all_with_description(text)
    all.find_all do |element|
      element.description.downcase.include?(text.downcase)
    end
  end

  def create(attributes)
    create_id_number
    attributes[:id] = create_id_number
    generate_item(attributes)
  end

  def generate_item(attributes)
    item = Item.new(attributes)
    @elements[item.id] = item
    @merchant_ids[item.merchant_id] << item
  end

  def delete(id)
    item = find_by_id(id)
    return nil unless item
    @merchant_ids.delete(item.merchant_id)
    super(id)
  end
end
