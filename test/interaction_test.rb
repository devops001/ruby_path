#!/usr/bin/env ruby

require_relative 'test_helper'

class TestInteraction < Minitest::Test

  def setup
    @rat1   = Creature.new("Rat", "a rat")
    @rat2   = Creature.new("Rat", "a rat")
    @ambush = Interaction.new("Ambush", "an ambush")
    @ambush.add_creature(@rat1)
    @ambush.add_creature(@rat2)
  end

  def test_load_all
    interactions = Interaction.load_all
    assert(interactions.count >= 2)
    ambush     = interactions["ambush"]
    dark_alley = interactions["dark_alley"]
    assert_equal("Ambush", ambush.name)
    assert_equal("Dark Alley", dark_alley.name)
    assert(ambush.creatures.count >= 1)
    assert(dark_alley.creatures.count >= 2)
    assert_equal(false, ambush.completed?)
    assert_equal(false, dark_alley.completed?)
  end

  def test_creatures
    assert_equal(2, @ambush.creatures.count)
  end

  def test_completed?
    assert_equal(false, @ambush.completed?)
    @ambush.creatures.map { |c| c.take_damage(c.hp) }
    assert_equal(true, @ambush.completed?)
  end

end

