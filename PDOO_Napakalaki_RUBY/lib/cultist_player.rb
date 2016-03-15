#!/bin/env ruby
# encoding: utf-8


require_relative 'cultist.rb'

module Napakalaki
  
  class CultistPlayer < Player
    @@total_cultist_players = 0
  
    
    def initialize (p,c)
      super("",p)
      @my_cultits_card = c
      @@total_cultist_players += 1
    end
    

    protected
    
     def get_combat_level
       total = super.get_combat_level
       porcentaje = (20 * total)/100
       
       calculo_total = (total + porcentaje + @my_cultits_card.get_gained_levels)*@@total_cultist_players
       
       calculo_total
     end
     

     def get_oponent_level(m)
       return m.get_combat_level_against_cultist_player
     end
     
     
     def should_convert
       false
     end

     def give_me_a_treasure
       posicion_aleatoria = rand(super.getVisibleTreasures.size)
       treasure = super.getVisibleTreasure.at(posicion_aleatoria)
       treasure
     end 

     def can_you_give_me_a_treasure
       enemigo = super.get_enemy
       can_i = true
       
       if(enemigo.getVisibleTreasures.empty?)
         can_i = false
       end
       
       can_i
     end
     
     def getTotalCultistPlayers
       @@total_cultist_players
     end
     
      def to_s
        "#{super.to_s} ERES SECTARIO!! #{@my_cultits_card.to_s}" 
      end
  end
  
end
