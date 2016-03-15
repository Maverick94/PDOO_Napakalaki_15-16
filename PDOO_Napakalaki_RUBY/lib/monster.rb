#!/bin/env ruby
# encoding: utf-8

require_relative 'prize.rb'
require_relative 'bad_consequence.rb'


module Napakalaki
  class Monster
    attr_reader :name, :CombatLevel, :BadConsequence, :Price
    
    def initialize (name, level, price, badConsequence, levelcultist=0)
      @name = name
      @CombatLevel = level
      @Price = price
      @BadConsequence = badConsequence
      @levelChangeAgainstCultistPlayer = levelcultist
    end
    
    

    public

    def get_levels_gained()
      @Price.level 
    end
    
    def get_treasures_gained()
      @Price.treasure 
    end
    
    def get_combat_level_against_cultist_player()
       return(@CombatLevel + @levelChangeAgainstCultistPlayer)
    end
    
    def to_s
    	 "\n \n Nombre: #{@name} 
        \n Nivel de combate: #{@CombatLevel} 
        \n Buen rollo: #{@Price.to_s}        
        \n Mal rollo: #{@BadConsequence.to_s}"
    end
  end
end