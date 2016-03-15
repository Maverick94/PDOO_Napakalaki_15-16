module PruebaNapakalaki
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