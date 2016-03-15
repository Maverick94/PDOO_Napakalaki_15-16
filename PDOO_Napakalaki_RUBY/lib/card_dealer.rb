#!/bin/env ruby
# encoding: utf-8

require_relative 'cultist.rb'
require_relative 'monster.rb'
require_relative 'treasure.rb'
require 'singleton'


module Napakalaki



class CardDealer
  
  include Singleton
  
  #Constructores
  
  def initialize
    @unused_monsters = Array.new
    @used_monsters= Array.new
    @unused_treasures= Array.new
    @used_treasures= Array.new
    @unused_cultists = Array.new
    @used_cultists = Array.new 
  end
  

  
  #Métodos privados
  private
  
  def init_cultist_card_deck()
    @unused_cultists << Cultist.new("Sectario", 1)
    @unused_cultists << Cultist.new("Sectario", 2)
    @unused_cultists << Cultist.new("Sectario", 1)
    @unused_cultists << Cultist.new("Sectario", 2)
    @unused_cultists << Cultist.new("Sectario", 1)
    @unused_cultists << Cultist.new("Sectario", 1)    
  end
  
  def init_treasure_card_deck()
        
    @unused_treasures << Treasure.new("¡Sí mi amo!", 4, TreasureKind::HELMET)
    @unused_treasures << Treasure.new("Botas de investigación", 3, TreasureKind::SHOES)
    @unused_treasures << Treasure.new("Capucha de Cthulhu", 3, TreasureKind::HELMET)
    @unused_treasures << Treasure.new("A prueba de babas", 2, TreasureKind::ARMOR)
    @unused_treasures << Treasure.new("Botas de lluvia ácida", 1, TreasureKind::SHOES)
    @unused_treasures << Treasure.new("Casco minero", 2, TreasureKind::HELMET)
    @unused_treasures << Treasure.new("Ametralladora Thompson", 4, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Camiseta de la UGR", 1, TreasureKind::ARMOR)
    @unused_treasures << Treasure.new("Clavo del rail ferroviario", 3, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Cuchillo de sushi arcano", 2, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Fez alópodo", 3, TreasureKind::HELMET)
    @unused_treasures << Treasure.new("Hacha prehistórica", 2, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("El aparato del pr. Tesla", 4, TreasureKind::ARMOR)
    @unused_treasures << Treasure.new("Gaita", 4, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Insecticida", 2, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Escopeta de 3 cañones", 4, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Garabato místico", 2, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("La rebeca metálica", 2, TreasureKind::ARMOR)
    @unused_treasures << Treasure.new("Lanzallamas", 4, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Necro-comicón", 1, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Necromicón", 5, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Linterna a 2 manos", 3, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Necro-gnomicón", 2, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Necrotelecom", 2, TreasureKind::HELMET)
    @unused_treasures << Treasure.new("Mazo de los antiguos", 3, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Necro-playboycón", 3, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Porra preternatural", 2, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Shogulador", 1, TreasureKind::BOTHHANDS)
    @unused_treasures << Treasure.new("Varita de atizamiento", 3, TreasureKind::ONEHAND)
    @unused_treasures << Treasure.new("Tentaculo de pega", 2, TreasureKind::HELMET)
    @unused_treasures << Treasure.new("Zapato deja-amigos", 1, TreasureKind::SHOES)
   
  end
  
  
  
  def init_monster_card_deck()

    # Los hondos
    bc = BadConsequence.new_death("Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estas muerto")
    price = Prize.new(2,1)
    @unused_monsters << Monster.new("Los hondos", 8, price, bc)

    # 3 Byakhees de bonanza
    bc = BadConsequence.new_level_specific_treasures("Pierdes tu armadura visible y oculta",0, [TreasureKind::ARMOR],[TreasureKind::ARMOR])
    price = Prize.new(2,1)
    @unused_monsters << Monster.new("3 Byakhees de bonanza", 8, price, bc)

    #Chibithulhu

    bc = BadConsequence.new_level_specific_treasures("Embobados con el lindo primigenio te descartas de tu casco visible",0,[TreasureKind::HELMET], Array.new())
    price = Prize.new(1,1)
    @unused_monsters << Monster.new("Chibithulhu", 2, price, bc)

    #El sopor de Dunwich

    bc = BadConsequence.new_level_specific_treasures("El primordial bostezo contagioso. Pierdes el calzado visible",0,[TreasureKind::SHOES],Array.new())
    price = Prize.new(1,1)
    @unused_monsters << Monster.new("El sopor de Dunwich", 2, price, bc)

    #Ángeles de la noche ibicenca

    bc = BadConsequence.new_level_number_of_treasures("Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta",0,1,1)
    price = Prize.new(4,1)
    @unused_monsters << Monster.new("Angeles de la noche ibicenca",14,price, bc)

    #El gorron en el umbral

    bc = BadConsequence.new_level_number_of_treasures("Pierdes todos tus tesoros visibles",0,10,0) #provisional
    price = Prize.new(3,1)
    @unused_monsters << Monster.new("El gorron en el umbral", 10, price, bc)

    #H.P. Munchcraft

    bc = BadConsequence.new_level_specific_treasures("Pierdes la armadura visible",0,[TreasureKind::ARMOR], Array.new())
    price = Prize.new(2,1)
    @unused_monsters << Monster.new("H.P. Munchcraft", 6, price, bc)

    #Bichgooth

    bc = BadConsequence.new_level_specific_treasures("Sientes bichos bajo la ropa. Descarta la armadura visible",0,[TreasureKind::ARMOR], Array.new())
    price = Prize.new(1,1)
    @unused_monsters << Monster.new("Bichgooth", 2, price, bc)


    #El rey de rosa

    bc = BadConsequence.new_level_number_of_treasures("Pierdes 5 niveles y 3 tesoros visibles",5,3,0)
    price = Prize.new(4,2)
    @unused_monsters << Monster.new("El rey de rosa", 13, price, bc)


    #La que redacta en las tinieblas

    bc = BadConsequence.new_level_number_of_treasures("Toses los pulmones y pierdes 2 niveles",2,0,0)
    price = Prize.new(1,1)
    @unused_monsters << Monster.new("La que redacta en las tinieblas", 2, price, bc)

    #Semillas Cthulhu

    bc = BadConsequence.new_level_number_of_treasures("Pierdes 2 niveles y 2 tesoros ocultos",2,0,2)
    price = Prize.new(2,1)
    @unused_monsters << Monster.new("Semillas Cthulhu", 4, price, bc)

    #Dameargo

    bc = BadConsequence.new_level_specific_treasures("Te intentas escaquear. Pierdes una mano visible",0,[TreasureKind::ONEHAND], Array.new())
    price = Prize.new(2,1)
    @unused_monsters << Monster.new("Dameargo", 1, price, bc)

    #Pollipólipo volante

    bc = BadConsequence.new_level_number_of_treasures("Da mucho asquito. Pierdes 3 niveles",3,0,0)
    price = Prize.new(1,1)
    @unused_monsters << Monster.new("Pollipólipo volante", 3, price, bc)

    #Yskhtihyssg-Goth

    bc = BadConsequence.new_death("No le hace gracia que pronuncien mal su nombre. Estas muerto")
    price = Prize.new(3,1)
    @unused_monsters << Monster.new("Yskhtihyssg-Goth", 13, price, bc)

    #Familia feliz

    bc = BadConsequence.new_death("La familia te atrapa. Estás muerto")
    price = Prize.new(4,1)
    @unused_monsters << Monster.new("Familia feliz", 1, price, bc)

    #Roboggoth

    bc = BadConsequence.new_level_specific_treasures("La quinta directiva primaria te obliga a perder 2 niveles y un tesoro de dos manos visible",2,[TreasureKind::BOTHHANDS], Array.new())
    price = Prize.new(2,1)
    @unused_monsters << Monster.new("Roboggoth", 8, price, bc)

    #El espia

    bc = BadConsequence.new_level_specific_treasures("Te asusta en la noche. Pierdes un casco visible",0,[TreasureKind::HELMET], Array.new())
    price = Prize.new(1,1)
    @unused_monsters << Monster.new("El espia", 5, price, bc)

    #El lenguas

    bc = BadConsequence.new_level_number_of_treasures("Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles",2,5,0)
    price = Prize.new(1,1)
    @unused_monsters << Monster.new("El lenguas", 20, price, bc)

    #Bicefalo

    bc = BadConsequence.new_level_specific_treasures("Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos",3,[TreasureKind::BOTHHANDS], Array.new())
    price = Prize.new(1,1)
    @unused_monsters << Monster.new("Bicefalo", 20, price, bc)
    
    
    #El mal indecible impronunciable
    
    bc = BadConsequence.new_level_specific_treasures("Pierdes una mano visible",0,TreasureKind::ONEHAND, Array.new());
    price = Prize.new(3,1);
    @unused_monsters << Monster.new("El mal indecible impronunciable",10,bc,price,-2)

    #Testigos Oculares
    
    bc = BadConsequence.new_level_number_of_treasures("Pierdes tus tesoros visibles. Jajaja.",0,10,0)
    price = Prize.new(2,1)
    @unused_monsters << Monster.new("Testigos Oculares",6,bc,price,2)

    #El gran cthulhu
    
    bc = BadConsequence.new_death("Hoy no es tu día de suerte. Mueres")
    price = Prize.new(2,5)
    @unused_monsters << Monster.new("El gran Cthulhu",20,bc,price,4)
    
    #Serpiente Politico
    
    bc = BadConsequence.new_level_number_of_treasures("Tu gobierno te recorta 2 niveles",2,0,0)
    price = Prize.new(2,1)
    @unused_monsters << Monster.new("Serpiente Político",8,bc,price,-2)

    #Felpuggoth
    
    bc = BadConsequence.new_level_specific_treasures("Pierdes tu casco y tu armadura visible, Pierdes tu manos ocultas",0,[TreasureKind::ARMOR,TreasureKind::HELMET],[TreasureKind::BOTHHANDS,TreasureKind::ONEHAND,TreasureKind::ONEHAND])
    price = Prize.new(1,1);
    @unused_monsters << Monster.new("Felpuggoth",2,bc,price,5)
    
    #Shoggoth
    
    bc = BadConsequence.new_level_number_of_treasures("Pierdes 2 niveles",2,0,0)
    price = Prize.new(4,2)
    @unused_monsters << Monster.new("Shoggoth",14,bc,price,-4)
    
    #Lolitagooth
    
    bc = BadConsequence.new_level_number_of_treasures("Pintalabios negro. Pierdes 2 niveles",2,0,0)
    price = Prize.new(1,1)
    @unused_monsters << Monster.new("Lolitagooth",2,bc,price,3)

    shuffle_monsters()
   
    
  end
  
  
  def shuffle_treasures()
    @unused_treasures = @unused_treasures.shuffle
  end
  
  def shuffle_cultists()
    @unused_cultists = @unused_cultists.shuffle
  end
  
  def shuffle_monsters()
    @unused_monsters = @unused_monsters.shuffle
  end
  
  
  public
  
  
#  def next_treasure()
#    if @unused_treasures.empty?
#      @used_treasures.each do |item|
#        @unused_treasures << item
#      end
#      shuffle_treasures
#    end
#    shuffle_treasures
#    
##    descartar_tesoro = rand(@unused_treasures.size)
##    tesoro_usado = @unused_treasures[descartar_tesoro]
##    @unused_treasures.delete(tesoro_usado) 
##    puts "hola tesoros"
#    tesoro = @unused_treasures.at(0)
#    @unused_treasures.delete(tesoro)
#    puts "hola, estoy devolviendo un tesoro" 
#    puts tesoro
#    tesoro
#  end

  def next_treasure() #Version de david

    @unused_treasures.to_s
    
    treasure = @unused_treasures.at(0)
    @unused_treasures.delete_at(0)
    if(@unused_treasures.empty?)
       @unused_treasures = @used_treasures.clone
       shuffle_treasures
      @used_treasures.clear
    end 
    treasure
  end
 
  
  def next_monster()
    if(@unused_monsters.empty?)
      @used_monsters.each do |item|
        @unused_monsters << item
      end
    end
    shuffle_monsters
    monstruo = @unused_monsters.at(0)
    @unused_monsters.delete(monstruo)
    monstruo
  end
  
  
    def next_cultist()
    if(@unused_cultists.empty?)
      @used_cultists.each do |item|
        @unused_cultists << item
      end
    end
    shuffle_cultists
    sectario = @unused_cultists.at(0)
    @unused_cultists.delete(sectario)
    sectario
  end
  
  
  def give_treasure_back(t)
    @used_treasures << t
  end
  
  
  def give_monster_back(m)
    @used_monsters << m
  end
  
  
  def init_cards()
    init_treasure_card_deck()
    init_monster_card_deck()
    init_cultist_card_deck()
  end
  
  
end
end