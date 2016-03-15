# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class NumericBadConsequence < BadConsequence
  def initialize(a_text,some_levels,v,h,death)
    super(a_text,some_levels,v,h,Array.new,Array.new,death)
  end
  
    def is_empty()
      
      empty = false
      
      if(@levels == 0 && @some_hidden_treasures == 0 && @some_visible_treasures == 0)
          empty = true;
      end

     empty
     
    end
  
  
end
