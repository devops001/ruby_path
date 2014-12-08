#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative 'cards'

class TestCard < Minitest::Test
  def setup
    @card = Card.new("Test Card", "this is a test card")
  end
  def test_name
    assert_equal("Test Card", @card.name)
  end
  def test_desc
    assert_equal("this is a test card", @card.desc)
  end
end

class TestCreature < Minitest::Test
  def setup
    @rat = Creature.new("Rat", "a rat")
  end

  def test_default_attributes
    assert_equal(1, @rat.power)
    assert_equal(1, @rat.defense)
    assert_equal(@rat.hp, @rat.max_hp)
    assert(@rat.hp >= 3)
  end

  def test_attack
    amounts = Hash.new(0)
    100.times do
      amount = @rat.attack()
      amounts[amount] += 1
      assert(amount >= 1)
    end
    assert(amounts.keys.length > 3)
  end

  def test_defend
    amounts = Hash.new(0)
    100.times do
      amount = @rat.defend(6)
      amounts[amount] += 1
      assert(amount >= 0)
    end
    assert(amounts.keys.length > 3)
  end

  def test_take_damage_and_heal
    starting_hp = @rat.hp
    amount = 2
    assert(starting_hp >= amount)
    100.times do 
      assert_equal(amount, @rat.take_damage(amount))
      assert_equal(starting_hp-amount, @rat.hp)
      assert_equal(amount, @rat.heal(amount))
      assert_equal(starting_hp, @rat.hp)
    end
  end

  def test_dead_and_alive
    amount = @rat.hp
    assert(@rat.hp > 0)
    assert(@rat.alive?)
    assert_equal(false, @rat.dead?)
    @rat.take_damage(amount)
    assert(@rat.hp == 0)
    assert(@rat.dead?)
    assert_equal(false, @rat.alive?)
  end

end

