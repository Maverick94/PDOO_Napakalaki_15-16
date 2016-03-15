#!/bin/env ruby
# encoding: utf-8


require_relative 'bad_consequence.rb'
require_relative 'monster.rb'
require_relative 'treasure_kind.rb'

module Napakalaki

class Prize
  attr_reader :treasure, :level

  def initialize(treasure,level)
    @treasure=treasure
    @level=level
  end

  def to_s
    "\n - Tesoros ganados: #{@treasure} 
     \n - Niveles ganados: #{@level}"
  end
end
end