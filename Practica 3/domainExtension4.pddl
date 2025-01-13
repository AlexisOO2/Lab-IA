(define (domain redflix_optimized)
  (:requirements :strips :typing :adl :fluents)

  (:types
    contenido - object
    dia - object
  )

  (:predicates
    (predecesor ?c1 - contenido ?c2 - contenido)    ; ?c1 es predecesor de ?c2
    (contenidoDisponible ?c - contenido)           ; El contenido está disponible
    (contenidoVisto ?c - contenido)                ; El usuario ha visto este contenido
    (contenidoPorVer ?c - contenido)               ; Contenido planificado para ver
    (enDia ?c - contenido ?d - dia)                ; Contenido ?c asignado al día ?d
    (diaAnterior ?d1 ?d2 - dia)                    ; Día anterior a otro día
    (paralelo ?c1 - contenido ?c2 - contenido)      ; Contenidos paralelos
  )

  (:functions
    (duracion ?c - contenido)                      ; Duración de contenido en minutos
    (minutosDia ?d - dia)                          ; Minutos usados en un día
  )

  (:action verContenido
    :parameters (?c - contenido ?d - dia)
    :precondition (and
      (contenidoDisponible ?c)
      (not (contenidoVisto ?c))
      (not (contenidoPorVer ?c))
      (<= (+ (duracion ?c) (minutosDia ?d)) 200)  ; Restricción de minutos diarios
      (forall (?c1 - contenido)
        (and
          (imply (predecesor ?c1 ?c)
            (and
              (contenidoVisto ?c1)        ; Predecesor debe estar visto
              (exists (?d1 - dia)
                (and
                  (enDia ?c1 ?d1)
                  (diaAnterior ?d1 ?d)    ; Predecesor en día anterior
                )
              )
            )
          )
          (imply (paralelo ?c1 ?c)
              (and
                (contenidoVisto ?c1)
                (exists (?d2 - dia)
                  (or
                    (enDia ?c1 ?d)
                    (diaAnterior ?d2 ?d)
                    (diaAnterior ?d ?d2)
                  )
                )
              )
          )
        )
      )
    )
    :effect (and
      (contenidoVisto ?c)
      (contenidoPorVer ?c)
      (enDia ?c ?d)
      (increase (minutosDia ?d) (duracion ?c))
    )
  )
)