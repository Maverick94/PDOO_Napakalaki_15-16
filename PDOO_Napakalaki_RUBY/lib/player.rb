#!/bin/env ruby
# encoding: utf-8



require_relative 'treasure.rb'
require_relative 'bad_consequence.rb'
require_relative 'card_dealer.rb'
require_relative 'dice.rb'
require_relative 'combat_result.rb'

module Napakalaki

class Player
  
  attr_accessor :name, :level, :hidden_treasures, :visible_treasures

  ###########################################################
  
  def initialize(nombre, p = nil)
    if(p == nil)
      @name = nombre
      @level = 1
      @dead = true
      @can_i_steal = true
      @enemy 
      @hidden_treasures = Array.new
      @visible_treasures = Array.new
      @pending_bad_consequence = BadConsequence.new_level_number_of_treasures(" ",1,0,0)
      @steal = false
      @@MAXLEVEL = 10
    else
      
      @dead = p.dead
      @name = p.name
      @level = p.level
      @can_i_steal = p.can_i_steal
      @enemy = p.enemy
      @steal = p.steal
      p.hiddenTreasures.each { |t|
        @hiddenTreasures.push(t)
      }
      p.visibleTreasures.each { |t|
        @visibleTreasures.push(t)
      }
      @pendingBadConsequence = p.pendingBadConsequence
    end
  end
  
  
  ###########################################################
  
  
  def bring_to_life
    @dead = false
  end
  

  
  ###########################################################
  
  def increment_levels(l)
    while l > 0
     @level = @level + 1
     l = l - 1
    end
  end
  
  ###########################################################
  
  def decrement_levels(l)
    while l > 0
     @level = @level - 1
     l = l - 1
    end
  end
  
  ###########################################################
  
  def set_pending_bad_consequence(b)
    @pending_bad_consequence = b
  end
  
  def get_enemy
    @enemy
  end
  ###########################################################
  
  def apply_prize(m)
    n_levels = m.get_levels_gained
    increment_levels(n_levels)
    n_treasures = m.get_treasures_gained
    
    if n_treasures > 0
      dealer = CardDealer.instance
      
      for i in 0..n_treasures
        treasure = dealer.next_treasure
        @hidden_treasures << treasure
      end
      
    end
    
  end
  
  ###########################################################
  
  def apply_bad_consequence(m)
    bad_consequence = m.BadConsequence
    n_levels = bad_consequence.get_level
    decrement_levels(n_levels)
    bad_consequence.levels = 0
    
    if (bad_consequence.death || n_levels > @level)
      @level = 0
      @dead = true
      @visible_treasures.clear
      @hidden_treasures.clear
      bad_consequence.some_visible_treasures = 0
      bad_consequence.some_hidden_treasures = 0
      bad_consequence.delete_specific_visible_treasures
      bad_consequence.delete_specific_hidden_treasures
      
      @pending_bad_consequence = bad_consequence
      set_pending_bad_consequence(@pending_bad_consequence)
    else
      
      @pending_bad_consequence = bad_consequence.adjust_to_fit_treasure_lists(@visible_treasures, @hidden_treasures)
      set_pending_bad_consequence(@pending_bad_consequence)
    end

    

  end
  
  ###########################################################
  

  
  def can_make_treasure_visible(t)
    
    can_make = true
    hands = 0
    bothhands = false
    
    for i in 0..@visible_treasures.size-1
      if(@visible_treasures[i].type == TreasureKind::ONEHAND)
        hands = hands +1
      end
      if(@visible_treasures[i].type == TreasureKind::BOTHHANDS)
        bothhands = true
      end
    end
    
    if(t.type == TreasureKind::BOTHHANDS)
      if (hands == 0 && !bothhands)
        can_make = true
      else
        can_make = false
      end
    else
      if(t.type == TreasureKind::ONEHAND)
          if(hands <=1 && !bothhands)
            can_make = true
          else
            can_make = false
          end
      end
    end
    if(t.type != TreasureKind::BOTHHANDS)
      
      @visible_treasures.each do |iterator|
        if(iterator.type == t.type)
          can_make = false
        end
      end
    end
    can_make
  end

  ###########################################################
  
  def how_many_visible_treasures(tKind)
    tesorostotales = 0
    
    for i in 0..@visible_treasures.size()
      if @visible_treasures[i].type == tKind
          tesorostotales = tesorostotales + 1
      end
    end
    tesorostotales
  end
  
  ###########################################################
  
  def die_if_no_treasures()
    if (@hidden_treasures.empty? && @visible_treasures.empty?)
      @dead = true
    end
  end
  
  ###########################################################
  
  def is_dead
    @dead
  end
 
  
  ###########################################################
  
  def combat(m)
    resultado = nil
    my_level = get_combat_level
    monster_level = get_oponent_level(m)
    if(my_level > monster_level)
      apply_prize(m)
      if(@level >= 10)
        resultado = CombatResult::WINGAME 
      else
        resultado = CombatResult::WIN 
      end
    
    else
      apply_bad_consequence(m)
      if(should_convert)
        resultado = CombatResult::LOSEANDCONVERT
      else
       resultado = CombatResult::LOSE
      end
    end
    resultado
  end
  
  
  ###########################################################
  
  def makeTreasureVisible(t)
    can_i = can_make_treasure_visible(t)
    
    if(can_i)
      @visible_treasures << t
      @hidden_treasures.delete(t)
    end
  end
  
  ###########################################################
  
  def discard_visible_treasure(t)
    @visible_treasures.delete(t)
    
    if(@pending_bad_consequence != nil && !(@pending_bad_consequence.is_empty))
      @pending_bad_consequence.substract_visible_treasure(t) 
    end
    
    die_if_no_treasures
    
  end
  
  ###########################################################
  
  def discard_hidden_treasure(t)
    @hidden_treasures.delete(t)
    
    if(@pending_bad_consequence != nil && !@pending_bad_consequence.is_empty)
      @pending_bad_consequence.substract_hidden_treasure(t) 
    end
    
    die_if_no_treasures
  end
  
  ###########################################################
  
  def valid_state
    centinela = false
    puts 'validstate'
    puts @pending_bad_consequence
    puts @hidden_treasures.size
    
    if(@pending_bad_consequence.is_empty and @hidden_treasures.size <= 4)
       centinela = true
    
    end
    centinela
  end
  
  ###########################################################
  
  def init_treasures
    dealer = CardDealer.instance
    dice = Dice.instance
    
    bring_to_life
    
    
    treasure = dealer.next_treasure

    @hidden_treasures << treasure
    
    
    
    number = dice.next_number
    
    if (number == 1)
      treasure = dealer.next_treasure
      @hidden_treasures << treasure
    end
   
    if (number > 1 and number < 6)
      for i in 0..2
        treasure = dealer.next_treasure
        @hidden_treasures << treasure
      end
    end
    
      if( number == 6)
        for i in 0..3
          treasure = dealer.next_treasure
          @hidden_treasures << treasure
        end
      end
@hidden_treasures.to_s
  end
  
  ###########################################################
  
  def steal_treasure
    can_i = can_i_steal
    treasure = nil
    
    if(can_i)
      can_you = can_you_give_me_a_treasure
      
      if(can_you)
        treasure = give_me_a_treasure
        @hidden_treasures << treasure
        have_stolen
      end
    end
    treasure
  end
  
  ###########################################################
  
  def set_enemy(enemy)
    @enemy = enemy
  end
  
  ###########################################################
  def getVisibleTreasures
    @visible_treasures
  end
  
  ###########################################################
  def getHiddenTreasures
    @hidden_treasures
  end 
  ###########################################################
 
  def give_me_a_treasure
    objeto = 1 + rand(@hidden_treasures.size)
    return objeto
  end
  
  ###########################################################
  
  #No se si esta bien
  def canISteal
    @steal
  end
  
  ###########################################################
  
  #No se si esta bien
  def can_you_give_me_a_treasure #VIGILARLA
    
    if(!@hidden_treasures.isEmpty)
      true
    else
      false
    end
  end
  
  ###########################################################
  
  #No se si esta bien
  def have_stolen
      @can_i_steal = false
  end
  
  ###########################################################
  
  def discardAllTreasures
    treasure = nil
    
    for i in 0..@visible_treasures.size
      treasure = @visible_treasures[i]
      discard_visible_treasure(treasure)
    end
    for j in 0..@hidden_treasures.size
      treasure = @hidden_treasures[j]
      discard_hidden_treasure(treasure)
    end
  end
  
  
  protected
  
  
    def get_oponent_level(m)
      m.CombatLevel
    end
    
    def should_convert
      dado = Dice.instance 
      convert = true
      
      if(dado.next_number == 1)
        puts "Te has convertido en sectario!!"
        convert =true
      end
      
      convert
      
    end
    
 ###########################################################
  
  def get_combat_level()
    acumulador_bonus = 0
    
    @visible_treasures.size
    
    for i in 0..@visible_treasures.size - 1
      acumulador_bonus = acumulador_bonus + @visible_treasures[i].bonus
    end
    
    return @level + acumulador_bonus
  end

  public
  
  def to_s
  
  "#{@name}   \n -Nivel: #{@level}   \n -Nivel combate: #{get_combat_level} \n -Muerte: #{@dead} \n -Mal Rollo por cumplir #{@pending_bad_consequence.to_s}"
  
  end
end
end
