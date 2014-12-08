
class Card
  attr_accessor :name, :desc
  def initialize(name, desc)
    @name = name
    @desc = desc
  end
end

class Creature < Card
  attr_reader :power, :defense, :hp, :max_hp

  def initialize(name, desc, power=1, defense=1)
    super(name, desc)
    @power   = power
    @defense = defense
    @max_hp  = 3 + rand(6)
    @hp      = @max_hp
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

