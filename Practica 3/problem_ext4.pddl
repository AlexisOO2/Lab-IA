(define (problem p2) (:domain redflix_optimized)
    (:requirements :fluents)
(:objects 
Iron_Man Iron_Man_2 Iron_Man_3 - contenido
Dia1 Dia2 Dia3 Dia4 - dia

)

(:init
    (diaAnterior Dia1 Dia2)
    (diaAnterior Dia2 Dia3)
    (diaAnterior Dia3 Dia4)

    (= (minutosDia Dia1) 0)
    (= (minutosDia Dia2) 0)
    (= (minutosDia Dia3) 0)
    (= (minutosDia Dia4) 0)

    (contenidoDisponible Iron_Man)
    (contenidoDisponible Iron_Man_2)
    (contenidoDisponible Iron_Man_3)


    (=(duracion Iron_Man)60)
    (=(duracion Iron_Man_2)60)
    (=(duracion Iron_Man_3)60)


    (predecesor Iron_Man Iron_Man_2)
    (predecesor Iron_Man_2 Iron_Man_3)

)

(:goal (contenidoVisto Iron_Man_3)

)
)
