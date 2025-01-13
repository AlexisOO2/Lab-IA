(define (problem p1) (:domain redflix_ext3)
(:objects 
Spiderman_Homecoming Ant-Man Black_Panther Doctor_Strange Spiderman_Far_From_Home Capitana_Marvel Guardianes_de_la_Galaxia Eternals Iron_Man_3 Doctor_Strange_en_el_Multiverso_de_la_Locura - contenido
Dia1 Dia2 Dia3 Dia4 Dia5 Dia6 Dia7 - dia
)
(:init
  (diaAnterior Dia1 Dia2)
  (diaAnterior Dia2 Dia3)
  (diaAnterior Dia3 Dia4)
  (diaAnterior Dia4 Dia5)
  (diaAnterior Dia5 Dia6)
  (diaAnterior Dia6 Dia7)

  (contenidoDisponible Spiderman_Homecoming)
  (contenidoDisponible Ant-Man)
  (contenidoDisponible Black_Panther)
  (contenidoDisponible Doctor_Strange)
  (contenidoDisponible Spiderman_Far_From_Home)
  (contenidoDisponible Capitana_Marvel)
  (contenidoDisponible Guardianes_de_la_Galaxia)
  (contenidoDisponible Eternals)
  (contenidoDisponible Iron_Man_3)
  (contenidoDisponible Doctor_Strange_en_el_Multiverso_de_la_Locura)

  (predecesor Spiderman_Homecoming Spiderman_Far_From_Home)
  (predecesor Iron_Man_3 Guardianes_de_la_Galaxia)
  (predecesor Guardianes_de_la_Galaxia Capitana_Marvel)
  (predecesor Capitana_Marvel Black_Panther)
  (predecesor Black_Panther Doctor_Strange)
  (predecesor Doctor_Strange Ant-Man)
  (predecesor Ant-Man Spiderman_Homecoming)
  (predecesor Spiderman_Homecoming Spiderman_Far_From_Home)
  (predecesor Spiderman_Far_From_Home Eternals)
  (predecesor Eternals Doctor_Strange_en_el_Multiverso_de_la_Locura)

  (paralelo Spiderman_Homecoming Guardianes_de_la_Galaxia)
  (paralelo Black_Panther Guardianes_de_la_Galaxia)
  (paralelo Doctor_Strange Iron_Man_3)

)
(:goal (and (contenidoVisto Doctor_Strange) (contenidoVisto Ant-Man) ))
)
