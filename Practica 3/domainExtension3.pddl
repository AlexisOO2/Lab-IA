(define (domain redflix_ext3)
  (:requirements :strips :typing :adl)

  (:types
    contenido - object
    dia - object
  )

  (:predicates
    (predecesor ?c1 - contenido ?c2 - contenido)    ; ?c1 es predecesor de ?c2
    (contenidoDisponible ?c - contenido)            ; El contenido está disponible para ver
    (contenidoVisto ?c - contenido)                 ; El usuario ya ha visto este contenido
    (contenidoPorVer ?c - contenido)                ; Este contenido ya está planeado para que el usuario vea
    (enDia ?c - contenido ?d - dia)                 ; El contenido ?c está planeado para el día ?d
    (diaAnterior ?d1 ?d2 - dia)                     ; ?d1 es anterior a ?d2
    (paralelo ?c1 - contenido ?c2 - contenido)      ; ?c1 es paralelo a ?c2
    (contenidoAsignado1 ?d - dia)                   ; Contenido 1 del día
    (contenidoAsignado2 ?d - dia)                   ; Contenido 2 del día
    (contenidoAsignado3 ?d - dia)                   ; Contenido 3 del día
  )

  (:action verContenido
    :parameters (?c - contenido ?d - dia)
    :precondition (and
      (contenidoDisponible ?c)         ; El contenido está disponible
      (not (contenidoVisto ?c))        ; El contenido aún no ha sido visto
      (not (contenidoPorVer ?c))       ; El contenido no está planeado para otro día
      (or (not (contenidoAsignado1 ?d))   ; Si no hay contenidos asignados, asignamos el primero
          (and (contenidoAsignado1 ?d) (not (contenidoAsignado2 ?d)))   ; Si tiene 1 contenido, puede asignarse el segundo
          (and (contenidoAsignado1 ?d) (contenidoAsignado2 ?d) (not (contenidoAsignado3 ?d)))) ; Si tiene 2 contenidos, puede asignarse el tercero
      (forall (?c1 - contenido)
        (imply (predecesor ?c1 ?c)
          (and
            (contenidoVisto ?c1)        ; El predecesor debe estar visto
            (exists (?d1 - dia)
              (and
                (enDia ?c1 ?d1)
                (diaAnterior ?d1 ?d)    ; El predecesor debe estar asignado en un día anterior
              )
            )
          )
        )
      )
      (forall (?c2 - contenido)
        (imply (paralelo ?c ?c2)
          (and
            (contenidoVisto ?c2)
            (exists (?d2 - dia)
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
      (contenidoVisto ?c)            ; El contenido ahora está visto
      (contenidoPorVer ?c)           ; El contenido ahora está planeado para ser visto
      (enDia ?c ?d)                  ; Asignamos el contenido al día
      (when (not (contenidoAsignado1 ?d)) (contenidoAsignado1 ?d))   
      (when (and (contenidoAsignado1 ?d) (not (contenidoAsignado2 ?d))) (contenidoAsignado2 ?d))   
      (when (and (contenidoAsignado1 ?d) (contenidoAsignado2 ?d) (not (contenidoAsignado3 ?d))) (contenidoAsignado3 ?d))   
    )
  )
)
