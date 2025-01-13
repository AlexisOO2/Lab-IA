(define (domain redflix_optimized)
  (:requirements :strips :typing :adl :fluents)

  (:types
    contenido - object
    dia - object
  )

  (:predicates
    (predecesor ?c1 - contenido ?c2 - contenido)
    (contenidoDisponible ?c - contenido)
    (contenidoVisto ?c - contenido)
    (contenidoPorVer ?c - contenido)
    (enDia ?c - contenido ?d - dia)
    (diaAnterior ?d1 ?d2 - dia)
    (paralelo ?c1 - contenido ?c2 - contenido)
    (verificacionMinutos ?c - contenido ?d - dia) ; Predicado para verificación de minutos
  )

  (:functions
    (duracion ?c - contenido)
    (minutosDia ?d - dia)
  )

  (:action verContenido
    :parameters (?c - contenido ?d - dia)
    :precondition (and
      (contenidoDisponible ?c)
      (not (contenidoVisto ?c))
      (not (contenidoPorVer ?c))

      ; Predecesores vistos en días anteriores
      (forall (?c1 - contenido)
        (imply (predecesor ?c1 ?c)
          (and 
            (contenidoVisto ?c1)
            (exists (?d1 - dia)
              (and
                (enDia ?c1 ?d1)
                (diaAnterior ?d1 ?d)
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