#!/bin/env ruby
# encoding: utf-8


require_relative 'treasure_kind.rb'

module Napakalaki
  class Treasure
    attr_accessor :name, :bonus, :type

    def initialize(n, b, t)
      @name = n
      @bonus = b
      @type = t
    end

    def get_name
      @name
    end
    
    def get_bonus
      @bonus
    end
    
    def get_type
      @type
    end
    
    def to_s
     "\n -Nombre: #{@name} \n -Bonus: #{@bonus} \n -Tipo: #{@type}"      
    end

  end
end