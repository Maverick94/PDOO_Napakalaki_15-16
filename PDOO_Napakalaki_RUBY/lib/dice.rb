#!/bin/env ruby
# encoding: utf-8

require 'singleton'

module Napakalaki

class Dice
  
  include Singleton
  
  def initialize
    
  end
  
  def next_number
    number = 1 + rand(6)
    number
  end
end
end