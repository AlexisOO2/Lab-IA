(define (domain redflix_basic)
  (:requirements :strips :typing :adl)

  (:types
    contenido - object
  )

  (:predicates
    (predecesor ?c1 - contenido ?c2 - contenido)    ; ?c1 es predecesor de ?c2
    (contenidoDisponible ?c - contenido)            ; El contenido está disponible para ver
    (contenidoVisto ?c - contenido)                 ; El usuario ya ha visto este contenido
    (contenidoPorVer ?c - contenido)                ; Este contenido ya está planeado para que el usuario vea
  )

  (:action verContenido
    :parameters (?c - contenido)
    :precondition (and
      (contenidoDisponible ?c)
      (not (contenidoVisto ?c))
      (not (contenidoPorVer ?c))
      (forall (?c1 - contenido)
        (imply (predecesor ?c1 ?c)
          (contenidoVisto ?c1)
        )
      )
    )
    :effect (and
      (contenidoVisto ?c)
      (contenidoPorVer ?c)
    )
  )
)