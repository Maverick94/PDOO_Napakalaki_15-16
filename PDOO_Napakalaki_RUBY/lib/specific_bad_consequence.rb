# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class SpecificBadConsequence < BadConsequence

  def initialize(a_text,some_levels,v,h,death)
    super(a_text,some_levels,0,0,v,h,death)
  end
  
    def is_empty()
      
      empty = false
      
      if(@levels == 0 && @some_specific_hidden_treasures.empty? && @some_specific_visible_treasures.empty?)
          empty = true;
      end

     empty
     
    end  
    
    
    def delete_specific_visible_treasures
      @some_specific_visible_treasures.clear
    end
    
    def delete_specific_hidden_treasures
      @some_specific_hidden_treasures.clear
    end
  
end
