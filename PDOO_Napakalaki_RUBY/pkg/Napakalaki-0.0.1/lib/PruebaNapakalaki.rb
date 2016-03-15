#!/bin/env ruby
# encoding: utf-8

module PruebaNapakalaki

require_relative 'monster.rb'
require_relative 'bad_consequence.rb'
require_relative 'prize.rb'
require_relative 'treasure_kind.rb'
  
  #bc = BadConsequence.new()
  
 
  #p = Prize.new(2,2)
  
  #puts "tesoro:"
  #puts p.treasure
  #puts p.level

  monsters = Array.new

  # Los hondos
  bc = BadConsequence.new_death("Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estas muerto")
  price = Prize.new(2,1)
  monsters << Monster.new("Los hondos", 8, price, bc)
  
  # 3 Byakhees de bonanza
  bc = BadConsequence.new_level_specific_treasures("Pierdes tu armadura visible y oculta",0,TreasureKind::ARMOR,TreasureKind::ARMOR)
  price = Prize.new(2,1)
  monsters << Monster.new("3 Byakhees de bonanza", 8, price, bc)

  #Chibithulhu

  bc = BadConsequence.new_level_specific_treasures("Embobados con el lindo primigenio te descartas de tu casco visible",0,TreasureKind::HELMET, Array.new())
  price = Prize.new(1,1)
  monsters << Monster.new("Chibithulhu", 2, price, bc)

  #El sopor de Dunwich

  bc = BadConsequence.new_level_specific_treasures("El primordial bostezo contagioso. Pierdes el calzado visible",0,TreasureKind::SHOE,Array.new())
  price = Prize.new(1,1)
  monsters << Monster.new("El sopor de Dunwich", 2, price, bc)

  #Ángeles de la noche ibicenca

  bc = BadConsequence.new_level_number_of_treasures("Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta",0,1,1)
  price = Prize.new(4,1)
  monsters << Monster.new("Angeles de la noche ibicenca",14,price, bc)

  #El gorron en el umbral

  bc = BadConsequence.new_level_number_of_treasures("Pierdes todos tus tesoros visibles",0,100000,0)
  price = Prize.new(3,1)
  monsters << Monster.new("El gorron en el umbral", 10, price, bc)

  #H.P. Munchcraft

  bc = BadConsequence.new_level_specific_treasures("Pierdes la armadura visible",0,TreasureKind::ARMOR, Array.new())
  price = Prize.new(2,1)
  monsters << Monster.new("H.P. Munchcraft", 6, price, bc)

  #Bichgooth

  bc = BadConsequence.new_level_specific_treasures("Sientes bichos bajo la ropa. Descarta la armadura visible",0,TreasureKind::ARMOR, Array.new())
  price = Prize.new(1,1)
  monsters << Monster.new("Bichgooth", 2, price, bc)


  #El rey de rosa

  bc = BadConsequence.new_level_number_of_treasures("Pierdes 5 niveles y 3 tesoros visibles",5,3,0)
  price = Prize.new(4,2)
  monsters << Monster.new("El rey de rosa", 13, price, bc)


  #La que redacta en las tinieblas

  bc = BadConsequence.new_level_number_of_treasures("Toses los pulmones y pierdes 2 niveles",2,0,0)
  price = Prize.new(1,1)
  monsters << Monster.new("La que redacta en las tinieblas", 2, price, bc)

  #Semillas Cthulhu

  bc = BadConsequence.new_level_number_of_treasures("Pierdes 2 niveles y 2 tesoros ocultos",2,0,2)
  price = Prize.new(2,1)
  monsters << Monster.new("Semillas Cthulhu", 4, price, bc)

  #Dameargo

  bc = BadConsequence.new_level_specific_treasures("Te intentas escaquear. Pierdes una mano visible",0,TreasureKind::ONEHAND, Array.new())
  price = Prize.new(2,1)
  monsters << Monster.new("Dameargo", 1, price, bc)

  #Pollipólipo volante

  bc = BadConsequence.new_level_number_of_treasures("Da mucho asquito. Pierdes 3 niveles",3,0,0)
  price = Prize.new(1,1)
  monsters << Monster.new("Pollipólipo volante", 3, price, bc)

  #Yskhtihyssg-Goth

  bc = BadConsequence.new_death("No le hace gracia que pronuncien mal su nombre. Estas muerto")
  price = Prize.new(3,1)
  monsters << Monster.new("Yskhtihyssg-Goth", 13, price, bc)

  #Familia feliz

  bc = BadConsequence.new_death("La familia te atrapa. Estás muerto")
  price = Prize.new(4,1)
  monsters << Monster.new("Familia feliz", 1, price, bc)

  #Roboggoth

  bc = BadConsequence.new_level_specific_treasures("La quinta directiva primaria te obliga a perder 2 niveles y un tesoro de dos manos visible",2,TreasureKind::BOTHHAND, Array.new())
  price = Prize.new(2,1)
  monsters << Monster.new("Roboggoth", 8, price, bc)

  #El espia

  bc = BadConsequence.new_level_specific_treasures("Te asusta en la noche. Pierdes un casco visible",0,TreasureKind::HELMET, Array.new())
  price = Prize.new(1,1)
  monsters << Monster.new("El espia", 5, price, bc)

  #El lenguas

  bc = BadConsequence.new_level_number_of_treasures("Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles",2,5,0)
  price = Prize.new(1,1)
  monsters << Monster.new("El lenguas", 20, price, bc)

  #Bicefalo

  bc = BadConsequence.new_level_specific_treasures("Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos",3,TreasureKind::BOTHHAND, Array.new())
  price = Prize.new(1,1)
  monsters << Monster.new("Bicefalo", 20, price, bc)

  
  puts "Monstruos con nivel de combate superior a 10:"
  
  monsters.each do |monsters|

    if(monsters.CombatLevel > 10)
      puts monsters.to_s
    end
  end
  
  puts "\n\nMostrar monstruos que tenga un mal rollo que implique perdida de niveles"
  
  monsters.each do |monsters|

    if(monsters.BadConsequence.levels > 0) #Esto peta y no entiendo por que
      puts monsters.to_s
    end
  end
  
  puts "\n\nMostrar todos los monstruos que tengan buen rollo que indique una ganancia de niveles superior a 1"
  
    monsters.each do |monsters|
      
      if (monsters.Price.level > 1)
        puts monsters.to_s
      end
      
    end
  
end