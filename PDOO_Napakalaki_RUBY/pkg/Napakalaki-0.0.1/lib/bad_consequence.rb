module PruebaNapakalaki
  class BadConsequence
    private_class_method :new
    
    attr_reader :text, :levels, :some_visible_treasures, :some_hidden_treasures, 
                :some_specific_visible_treasures , :some_specific_hidden_treasures, :death
    
    def initialize(a_text,some_levels,some_visible_treasures,
                   some_hidden_treasures,some_specific_visible_treasures,
                   some_specific_hidden_treasures,death)
      @text = a_text
      @levels = some_levels
      @some_visible_treasures = some_visible_treasures
      @some_hidden_treasures = some_hidden_treasures
      @some_specific_visible_treasures = some_specific_visible_treasures
      @some_specific_hidden_treasures = some_specific_hidden_treasures
      @death = death
    end
    
    def BadConsequence.new_level_number_of_treasures(a_text,some_levels,some_visible_treasures,some_hidden_treasures)
      new(a_text,some_levels,some_visible_treasures,some_hidden_treasures,Array.new(),Array.new(),false)
    end
     
    def BadConsequence.new_level_specific_treasures(a_text,some_levels,some_specific_visible_trasures,some_specific_hidden_treasures)
      new(a_text,some_levels,0,0,some_specific_visible_trasures,some_specific_hidden_treasures,false)
    end
    
    def BadConsequence.new_death(a_text)
      new(a_text,0,0,0,Array.new(),Array.new(),true)
    end
    
    public

    def to_s
      "\n - Texto: #{@text} 
       \n - Niveles perdidos: #{@levels} 
       \n - Tesoros visibles: #{@some_visible_treasures} 
       \n - Tesoros ocultos: #{@some_hidden_treasures}
       \n - Objetos especificos visibles: #{@some_specific_visible_trasures}
       \n - Objetos especificos ocultos: #{@some_specific_hidden_treasures}
       \n - Muerto: #{@death}
      "      
    end
  end
end
