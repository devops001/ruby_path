
require 'yaml'
require 'pp'
require_relative 'card'

class Creature < Card
  attr_reader :power, :defense, :hp, :max_hp

  @@creatures = Hash.new

  def initialize(name, desc, power=1, defense=1, max_hp=nil)
    super(name, desc)
    @power   = power
    @defense = defense
    @max_hp  = max_hp.nil? ? 3+rand(6) : max_hp
    @hp      = @max_hp
  end

  def self.load_all
    @@creatures.clear
    data = YAML.load_file(File.join(__dir__, 'data', 'creatures.yml'))
    data.keys.each do |name|
      c = data[name]
      @@creatures[name] = Creature.new(c['name'], c['desc'], c['power'], c['defense'], c['max_hp'])
    end
    @@creatures
  end

  def attack
    @power + rand(6)
  end

  def defend(amount)
    hit = amount - (@defense + rand(6))
    hit>0 ? hit : 0
  end

  def take_damage(amount)
    if @hp - amount < 0
      amount = @hp
      @hp = 0
    else
      @hp -= amount
    end
    amount
  end

  def heal(amount)
    if @hp + amount > @max_hp
      amount = @max_hp - @hp
      @hp = @max_hp
    else
      @hp += amount
    end
    amount
  end

  def dead?
    @hp == 0
  end

  def alive?
    @hp > 0
  end
end

