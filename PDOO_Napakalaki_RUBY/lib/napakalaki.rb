#!/bin/env ruby
# encoding: utf-8


require 'singleton'
require_relative 'card_dealer.rb'
require_relative 'player.rb'
require_relative 'combat_result'

module Napakalaki
  

class Napakalaki
  
  include Singleton
  
  
  
  def initialize
   @current_monster
   @dealer = CardDealer.instance 
   @players = Array.new()
   @current_player 
  end
  
  
 
  
  #Métodos privados
  private
  
  def init_players(name) #Iniciacializa los jugadores por cada nombre que encuentra.
    name.each do |i|
      nuevo_jugador=Player.new(i)
      @players << nuevo_jugador
    end
    
    for i in 0..(@players.length-1)
      (@players.at(i)).init_treasures
    end

    next_player()
    
  end
  
  def next_player()
    num_players = @players.size()
    indice = 0
    
    if(@current_player == nil )
      indice = rand(num_players)
    else
      for i in 0..@players.size()-1
        if(@current_player == @players[i])
          indice = i
        end
      end
      indice = (indice + 1) % (num_players)
    end
      
    @current_player = @players[indice]      
    @current_player
  end
  
  def next_turn_allowed()
    stateOK = @current_player.valid_state()
    stateOK
  end
  
  def set_enemies()
    no_igual = false
    for i in 0..@players.size-1
      while !no_igual
        num_aletorio = rand(@players.size)
        if num_aletorio != i
          no_igual= true
          @players.at(i).set_enemy(@players.at(num_aletorio))
        end
      end   
    end
  end
  
  public
  
  #Métodos publicos
  def getCurrentPlayer
    @current_player
  end
  
  def getCurrentMonster
    @current_monster
  end
  
  def developCombat() #Devuelve un resultado
    combat = @current_player.combat(@current_monster)
    if(combat == CombatResult::LOSEANDCONVERT)
      sectario = @dealer.next_cultist
      jugador_sectario = CultistPlayer.new(@current_player,sectario)
      
      for i in 0..@players.size
        if(@players.at(i) == @current_player)
          @players[i] = jugador_sectario
        end
      end
      
      @current_player = jugador_sectario
    end
    @dealer.give_monster_back(@current_monster)
  end
  
  def discardVisibleTreasures(treasures)
    treasures.each do |temp|
      @current_player.discard_visible_treasure(temp)
      @dealer.give_treasure_back(temp)
    end  
  end
  
  def discardHiddenTreasures(treasures)
    treasures.each do |temp|
      @current_player.discard_hidden_treasure(temp)
      @dealer.give_treasure_back(temp)
    end
  end
  
  def make_treasures_visible(treasures)
    treasures.each do |t|
      @current_player.make_treasure_visible(t)
    end
  end
  
  def initGame(players)
    @dealer.init_cards()
    init_players(players)
    puts "paso por init players"
    set_enemies()
    @current_monster = @dealer.next_monster
   
    nextTurn()
  end
  
  def nextTurn()
    stateOK = next_turn_allowed()
    
    if(stateOK)
      @current_monster = @dealer.next_monster()
      @current_player = next_player()
      dead = @current_player.is_dead
      
      if(dead)
        @current_player.init_treasures
      end
    end
        
    stateOK
  end

  def end_of_game(result)
    centinela = false
    
    if(result == combat_result::WINGAME) 
      centinela = true
    end
    centinela
  end

  
  
end
end
