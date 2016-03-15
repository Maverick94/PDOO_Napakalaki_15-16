#!/bin/env ruby
# encoding: utf-8

require_relative 'treasure_kind.rb'

module Napakalaki
  class BadConsequence
    private_class_method :new
    
    attr_reader :text, :levels, :MAXTREASURES
    
    attr_accessor :levels, :death, :some_visible_treasures, :some_hidden_treasures, 
                :some_specific_visible_treasures , :some_specific_hidden_treasures
    
    MAXTREASURES = 10
    
    def initialize(a_text,some_levels,some_visible_treasures,some_hidden_treasures,v,h,death)
      @text = a_text
      @levels = some_levels
      @some_visible_treasures = some_visible_treasures
      @some_hidden_treasures = some_hidden_treasures
      @some_specific_visible_treasures = v
      @some_specific_hidden_treasures = h
      @death = death
    end
    
    #Constructores
    
    def BadConsequence.new_level_number_of_treasures(a_text,some_levels,some_visible_treasures,some_hidden_treasures)
      new(a_text,some_levels,some_visible_treasures,some_hidden_treasures, Array.new, Array.new,false)
    end
     
    def BadConsequence.new_level_specific_treasures(a_text,some_levels,some_specific_visible_trasures,some_specific_hidden_treasures)
      new(a_text,some_levels,0,0,some_specific_visible_trasures,some_specific_hidden_treasures,false)
    end
    
    def BadConsequence.new_death(a_text)
      new(a_text,0,0,0,Array.new,Array.new,true)
    end
    
    
    #Métodos
    
    
    public
   
    def get_level
      @levels
    end
    
    def delete_specific_visible_treasures
      raise NotImplementedError()
    end
    
    def delete_specific_hidden_treasures
      raise NotImplementedError()
    end
    
   
    
    def adjust_to_fit_treasure_lists(v,h)
      
      #Diferenciamos entre numero de tesoros o tipos.
      #################################################
      if ( @some_visible_treasures > 0 or @some_hidden_treasures > 0 )
        if (@some_visible_treasures > 0)
              if (@some_visible_treasures > v.size) 
                @some_visible_treasures = v.length
              end
        end
        
        if (@some_hidden_treasures > 0)
              if (@some_hidden_treasures > h.size)
                @some_hidden_treasures = h.length
              end
        end
      ################################################## 
      else
          aux = Array.new
          v.each do |treasureP|
            once = false
            @some_specific_visible_treasures.each do |treasureBC|
              if ( treasureBC == treasureP.type )
                 once = true
              end
            end
         
            if ( once )
              aux.push(treasureP.type)
              @some_specific_visible_treasures.delete(treasureP.type)
            end
          end
          @some_specific_visible_treasures.clear
          aux.each do |visibleT|
            @some_specific_visible_treasures.push(visibleT) 
          end
      
          aux.clear
          
          h.each do |treasureP|
            once = false
            @some_specific_hidden_treasures.each do |treasureBC|
              if ( treasureBC == treasureP.type )
                once = true
              end
            end
            if ( once )
              aux.push(treasureP.type)
              @some_specific_hidden_treasures.delete(treasureP.type)
            end
          end
          @some_specific_hidden_treasures.clear
          aux.each do |hiddenT|
            @some_specific_hidden_treasures.push(hiddenT) 
          end
      end
      self
    end
    
    def is_empty()
      raise NotImplementedError()
    end
    
    def substract_visible_treasure(t)
      if ( @some_visible_treasures > 0 )
        @some_visible_treasures = @some_visible_treasures - 1
      else
        if(t != nil)
          @some_specific_visible_treasures.delete(t.type)
        end
      end
    end
    
    def substract_hidden_treasure(t)
        if ( @some_hidden_treasures > 0 )
          @some_hidden_treasures = @some_hidden_treasures - 1
        else
          if(t != nil)
            @some_specific_hidden_treasures.delete(t.type)
          end
        end
    end 
    
    def to_s
      "\n - Texto: #{@text} 
       \n - Niveles perdidos: #{@levels} 
       \n - Tesoros visibles: #{@some_visible_treasures} 
       \n - Tesoros ocultos: #{@some_hidden_treasures}
       \n - Objetos especificos visibles: #{@some_specific_visible_treasures}
       \n - Objetos especificos ocultos: #{@some_specific_hidden_treasures}
       \n - Muerto: #{@death}
      "      
    end    
  end
end



