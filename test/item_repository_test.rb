require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    @ir = ItemRepository.new
  end

  def test_it_exists
    @ir = ItemRepository.new
    assert_instance_of ItemRepository, @ir
  end

  def test_it_can_create_items_from_csv
    @ir.from_csv('./data/items.csv')
    # ('./test/fixtures/item_fixtures.csv')
    assert_equal 1367, @ir.elements.count
    assert_instance_of Item, @ir.elements[263395237]
    assert_equal '510+ RealPush Icon Set', @ir.elements[263395237].name
    assert_instance_of Item, @ir.elements[263414049]
    assert_equal 'Snow fallen', @ir.elements[263414049].name
    assert_equal 'Minty Green Knit Crochet Infinity Scarf', @ir.elements[263567474].name

    assert_nil @ir.elements['id']
    assert_nil @ir.elements[999999999]
    assert_nil @ir.elements[0]
    # i = @ir.elements
    # binding.pry
    # assert_instance_of Item, @ir.elements[-1]
  end

  def test_all_method
    @ir.from_csv('./data/items.csv')
    all_items = @ir.all
    assert_equal 1367, all_items.count
    assert_instance_of Item, all_items[0]
    assert_instance_of Item, all_items[800]
    assert_instance_of Item, all_items[1366]
  end

  def test_find_by_id
    @ir.from_csv('./data/items.csv')
    item = @ir.find_by_id(263395237)
    assert_instance_of Item, item
    assert_equal '510+ RealPush Icon Set', item.name

    item2 = @ir.find_by_id(263414049)
    assert_instance_of Item, item2
    assert_equal 'Snow fallen', item2.name
  end


end