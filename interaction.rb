
require 'yaml'
require_relative 'card'

class Interaction < Card
  attr_reader :creatures

  def initialize(name, desc)
    super(name, desc)
    @creatures = []
  end

  def add_creature(creature)
    @creatures << creature
  end

  def completed?
    all_dead = true
    @creatures.each { |c| all_dead = false if c.alive? }
    all_dead
  end

end

