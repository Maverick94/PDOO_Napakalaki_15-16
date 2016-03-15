#!/bin/env ruby
# encoding: utf-8

  

module Napakalaki
  class Cultist
    
    def initialize(nombre,niveles)
      @name = nombre
      @gained_levels = niveles
    end
    
    def get_gained_levels
      @gained_levels
    end
    
    def to_s
      " \n Nombre: #{@name} \n Nivel: #{@gained_levels}"
    end
    
  end
end
  
