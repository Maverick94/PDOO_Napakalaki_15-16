module PruebaNapakalaki
  class Monster
    attr_reader :name, :CombatLevel, :BadConsequence, :Price
    
    def initialize (name, level, price, badConsequence)
      @name = name
      @CombatLevel = level
      @Price = price
      @BadConsequence = badConsequence
    end

    public

    def to_s
    	 "\n \n Nombre: #{@name} 
        \n Nivel de combate: #{@CombatLevel} 
        \n Buen rollo: #{@Price.to_s}        
        \n Mal rollo: #{@BadConsequence.to_s}"
    end
  end
end