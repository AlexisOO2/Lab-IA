(define (domain redflix)
  (:requirements :strips :typing :negative-preconditions :existential-preconditions)

  (:types
    contenido - object
  )

  (:predicates
    (predecesor ?c1 - contenido ?c2 - contenido)    ; ?c1 es predecesor de ?c2
    (contenidoDisponible ?c - contenido)            ; El contenido está disponible para ver
    (contenidoVisto ?c - contenido)                 ; El usuario ya ha visto este contenido
    (contenidoPorVer ?c - contenido)                ; Este contenido ya está planeado para que el usuario vea
    (enDia ?c - contenido ?d - object)              ; El contenido ?c está planeado para el día ?d
    (diaAnterior ?d1 ?d2 - object)                  ; ?d1 es anterior a ?d2
    (paralelo ?c1 - contenido ?c2 - contenido)      ; ?c1 es paralelo a ?c2
  )

  (:action verContenido
    :parameters (?c - contenido ?d - object)
    :precondition (and
      (contenidoDisponible ?c)
      (not (contenidoVisto ?c))
      (not (contenidoPorVer ?c))
      (forall (?c1 - contenido)
        (imply (predecesor ?c1 ?c)
          (and
            (contenidoVisto ?c1)        ; Predecesor debe estar visto
            (exists (?d1 - object)
              (and
                (enDia ?c1 ?d1)
                (diaAnterior ?d1 ?d)    ; Predecesor en día anterior
              )
            )
          )
        )
      )
      (forall (?c2 - contenido)
         (imply (paralelo ?c ?c2)
            (and
              (contenidoVisto ?c2)
              (exists (?d2 - object)
                 (or
                   (enDia ?c2 ?d)
                   (diaAnterior ?d2 ?d)
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
    )
  )
)