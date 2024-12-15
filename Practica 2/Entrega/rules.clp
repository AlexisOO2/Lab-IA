(defclass Recomendacion 
	(is-a USER)
	(role concrete)
    (slot nombre_obra
		(type INSTANCE)
		(create-accessor read-write))
    (slot puntuacion
        (type INTEGER)
        (create-accessor read-write))
    (multislot justificaciones
		(type STRING)
		(create-accessor read-write))
)

(defclass Dia
	(is-a USER)
	(role concrete)
	(multislot recomendaciones
		(type INSTANCE)
		(create-accessor read-write))
	(slot tiempo-maximo
		(type INTEGER)
		(create-accessor read-write))
)

;;; ---------------------------------------------------------
;;;                     MAIN
;;; ---------------------------------------------------------

(defmodule MAIN (export ?ALL))

;;; Modulo de recopilacion de los datos del usuario
(defmodule recopilacion-usuario
	(import MAIN ?ALL)
	(export ?ALL)
)

;;; Modulo de recopilacion de las preferencias del usuario
(defmodule recopilacion-prefs
	(import MAIN ?ALL)
    (import recopilacion-usuario deftemplate ?ALL)
	(export ?ALL)
)

(defmodule procesado-datos
	(import MAIN ?ALL)
	(import recopilacion-usuario deftemplate ?ALL)
	(import recopilacion-prefs deftemplate ?ALL)
	(export ?ALL)
)

(defmodule generacion_soluciones
	(import MAIN ?ALL)
	(export ?ALL)
)

(defmodule resultados_al_grupo
	(import MAIN ?ALL)
	(export ?ALL)
)
;;; ---------------------------------------------------------
;;;                     TEMPLATES
;;; ---------------------------------------------------------

;; Template para los datos del usuario o grupo
(deftemplate MAIN::datos_grupo
	(slot tamanyo (type INTEGER) (default 1)) ;tamanyo del grupo
	(slot nivel (type INTEGER)(default -1)) ;conocimiento
	(slot menores (type INTEGER)(default -1)) ; existe algun menor de edad
    (slot dias (type INTEGER)(default -1)) ;nº dias en visitar el museo
    (slot horasdia (type INTEGER)(default -1)) ;nº horas/dia
    (slot tiempo (type INTEGER)(default -1)) ;total de tiempo
)

;;; Template para las preferencias del usuario o grupo
(deftemplate MAIN::preferencias_grupo
	(slot autor_favorito (type INSTANCE))
    (slot obra_favorita (type INSTANCE))
    (slot tematica_favorita (type INSTANCE))
    (slot epoca_favorita (type INSTANCE))
    (slot estilo_favorito (type INSTANCE))
)

;;; Template para una lista de las obras que se van a visitar
(deftemplate MAIN::lista-obras-visita
	(multislot recomendaciones (type INSTANCE))
)


;;; ---------------------------------------------------------
;;;                     FUNCIONES
;;; ---------------------------------------------------------


;;; Funcion para hacer una pregunta numerica-univalor
(deffunction MAIN::pregunta-numerica (?pregunta ?rangini ?rangfi)
	(format t "%s (De %d hasta %d) " ?pregunta ?rangini ?rangfi)
	(bind ?respuesta (read))
	(while (not(and(>= ?respuesta ?rangini)(<= ?respuesta ?rangfi))) do
		(format t "%s (De %d hasta %d) " ?pregunta ?rangini ?rangfi)
		(bind ?respuesta (read))
	)
	?respuesta
)



;;; Funcion para hacer pregunta con muchas opciones
(deffunction MAIN::pregunta-opciones (?pregunta $?valores-posibles)
    (bind ?linea (format nil "%s" ?pregunta))
    (printout t ?linea crlf)
    (progn$ (?var ?valores-posibles)
            (bind ?linea (format nil "  %d. %s" ?var-index ?var))
            (printout t ?linea crlf)
    )
    (bind ?respuesta (pregunta-numerica "Escoge una opcion:" 1 (length$ ?valores-posibles)))
	?respuesta
)

; Funcion para hacer una pregunta multi-respuesta con indices
(deffunction MAIN::pregunta-multirespuesta (?pregunta $?valores-posibles)
    (bind ?linea (format nil "%s" ?pregunta))
    (printout t ?linea crlf)
    (progn$ (?var ?valores-posibles)
            (bind ?linea (format nil "  %d. %s" ?var-index ?var))
            (printout t ?linea crlf)
    )
    (format t "%s" "Indica los numeros referentes a los pintores separados por un espacio: ")
    (bind ?resp (readline))
    (bind ?numeros (explode$ ?resp))
    (bind $?lista (create$ ))
    (progn$ (?var ?numeros)
        (if (and (integerp ?var) (and (>= ?var 0) (<= ?var (length$ ?valores-posibles))))
            then
                (if (not (member$ ?var ?lista))
                    then (bind ?lista (insert$ ?lista (+ (length$ ?lista) 1) ?var))
                )
        )
    )
    (if (member$ 0 ?lista) then (bind ?lista (create$ 0)))
    ?lista
)

(defrule MAIN::initialRule "Regla inicial"
	(declare (salience 10))
	=>
	(printout t"----------------------------------------------------------" crlf)
  	(printout t"                Personalizacion de Visitas                " crlf)
	(printout t"----------------------------------------------------------" crlf)
  	(printout t crlf)
	(printout t"Bienvenido/s, por favor responda las siguientes preguntas para poder ofrecerle el mejor recorrido para su visita al museo" crlf)
	(printout t crlf)
	(focus recopilacion-usuario)
)

;;; ---------------------------------------------------------
;;;                     REGLAS
;;; ---------------------------------------------------------


;;; MODULO DE PREGUNTAS

(defrule recopilacion-usuario::establecer-tamanyo-grupo
    (not (datos_grupo))
	=>
	(bind ?tamanyo (pregunta-numerica "¿De cuantos visitantes esta formado el grupo? " 1 100))
    (assert (datos_grupo (tamanyo ?tamanyo)))
)

(defrule recopilacion-usuario::establecer-todos-mayores-edad
	?g <- (datos_grupo (menores ?menores))
	(test (< ?menores 0))
	=>
	(bind ?menores (pregunta-numerica "Es el Usuario o algun miembro del grupo menor de edad?" 0 1))
	(modify ?g (menores ?menores))
)

(defrule recopilacion-usuario::establecer-horas-visita
	?g <- (datos_grupo (horasdia ?horasdia))
	(test (< ?horasdia 0))
	=>
	(bind ?horasdia (pregunta-numerica "Cuantas horas quieres que dure cada visita? (h)" 1 8))
	(modify ?g (horasdia ?horasdia))
)

(defrule recopilacion-usuario::establecer-dias-visita
    ?g <- (datos_grupo (dias ?dias))
    (test (< ?dias 0))
    =>
    (bind ?dias (pregunta-numerica "Cuantos dias dispones para visitar el museo" 1 5))
    (modify ?g (dias ?dias))
)

(defrule recopilacion-usuario::establecer-tiempo-total
    ?g <- (datos_grupo(tiempo ?tiempo))
    (datos_grupo (dias ?dias) (horasdia ?horasdia))
    (test (< 0 ?dias)) (test (< 0 ?horasdia))
    =>
    (bind ?tiempo (* ?dias ?horasdia))
    (modify ?g (tiempo ?tiempo))
)

(defrule recopilacion-usuario::establecer-nivel-conocimiento
    ?g <- (datos_grupo (nivel ?nivel))
    (test (< ?nivel 0))
    =>
    (bind ?nivel (pregunta-numerica "Cual dirias que es tu nivel de conocimiento sobre el arte?" 0 10))
    (modify ?g (nivel ?nivel))
    (focus recopilacion-prefs)
)

(deffacts recopilacion-prefs::hechos-iniciales
    (autor_favorito nil)
    (obra_favorita nil)
    (tematica_favorita nil)
    (epoca_favorita nil)
    (estilo_favorito nil)
    (preferencias_grupo)
)

(defrule recopilacion-prefs::establecer-autor-preferido
    ?g <- (preferencias_grupo (autor_favorito ?autor))
    ?hecho <- (autor_favorito nil)
    =>
    (bind $?obj-pintores (find-all-instances ((?inst Pintor)) TRUE))
	(bind $?nom-pintores (create$ ))
	(loop-for-count (?i 1 (length$ $?obj-pintores)) do
		(bind ?curr-obj (nth$ ?i ?obj-pintores))
		(bind ?curr-nom (send ?curr-obj get-nombre))
		(bind $?nom-pintores(insert$ $?nom-pintores (+ (length$ $?nom-pintores) 1) ?curr-nom))
	)
    (bind ?indice (pregunta-opciones "Escoja su pintor favorito: " $?nom-pintores))
    (bind ?respuesta (nth$ ?indice ?obj-pintores))
    (modify ?g (autor_favorito ?respuesta))
    (retract ?hecho)
)

(defrule recopilacion-prefs::establecer-obra-preferida
    ?g <- (preferencias_grupo (obra_favorita ?obra))
    ?hecho <- (obra_favorita nil)
    =>
    (bind $?obj-obras (find-all-instances ((?inst ObraDeArte)) TRUE))
	(bind $?nom-obras (create$ ))
	(loop-for-count (?i 1 (length$ $?obj-obras)) do
		(bind ?curr-obj (nth$ ?i ?obj-obras))
		(bind ?curr-nom (send ?curr-obj get-nombre))
		(bind $?nom-obras(insert$ $?nom-obras (+ (length$ $?nom-obras) 1) ?curr-nom))
	)
    (bind ?indice (pregunta-opciones "Escoja sus obra favorita: " $?nom-obras))
    (bind ?respuesta (nth$ ?indice ?obj-obras))
    (modify ?g (obra_favorita ?respuesta))
    (retract ?hecho)
)



(defrule recopilacion-prefs::establecer-tematica-preferida
    ?g <- (preferencias_grupo (tematica_favorita ?obra))
    ?hecho <- (tematica_favorita nil)
    =>
    (bind $?obj-tematica (find-all-instances ((?inst Tematica)) TRUE))
	(bind $?nom-tematica (create$ ))
	(loop-for-count (?i 1 (length$ $?obj-tematica)) do
		(bind ?curr-obj (nth$ ?i ?obj-tematica))
		(bind ?curr-nom (send ?curr-obj get-nombre))
		(bind $?nom-tematica(insert$ $?nom-tematica (+ (length$ $?nom-tematica) 1) ?curr-nom))
	)
    (bind ?indice (pregunta-opciones "Escoja su tematica favorita: " $?nom-tematica))
    (bind ?respuesta (nth$ ?indice ?obj-tematica))
    (modify ?g (tematica_favorita ?respuesta))
    (retract ?hecho)
)


(defrule recopilacion-prefs::establecer-epoca-preferida
    ?g <- (preferencias_grupo (epoca_favorita ?obra))
    ?hecho <- (epoca_favorita nil)
    =>
    (bind $?obj-epoca (find-all-instances ((?inst Epoca)) TRUE))
	(bind $?nom-epoca (create$ ))
	(loop-for-count (?i 1 (length$ $?obj-epoca)) do
		(bind ?curr-obj (nth$ ?i ?obj-epoca))
		(bind ?curr-nom (send ?curr-obj get-nombre))
		(bind $?nom-epoca(insert$ $?nom-epoca (+ (length$ $?nom-epoca) 1) ?curr-nom))
	)
    (bind ?indice (pregunta-opciones "Escoja su epoca favorita: " $?nom-epoca))
    (bind ?respuesta (nth$ ?indice ?obj-epoca))
    (modify ?g (epoca_favorita ?respuesta))
    (retract ?hecho)
)


(defrule recopilacion-prefs::establecer-estilo-preferido
    ?g <- (preferencias_grupo (estilo_favorito ?obra))
    ?hecho <- (estilo_favorito nil)
    =>
    (bind $?obj-estilo (find-all-instances ((?inst Estilo)) TRUE))
	(bind $?nom-estilo (create$ ))
	(loop-for-count (?i 1 (length$ $?obj-estilo)) do
		(bind ?curr-obj (nth$ ?i ?obj-estilo))
		(bind ?curr-nom (send ?curr-obj get-nombre))
		(bind $?nom-estilo(insert$ $?nom-estilo (+ (length$ $?nom-estilo) 1) ?curr-nom))
	)
    (bind ?indice (pregunta-opciones "Escoja su estilo favorita: " $?nom-estilo))
    (bind ?respuesta (nth$ ?indice ?obj-estilo))
    (modify ?g (estilo_favorito ?respuesta))
    (retract ?hecho)
    (printout t "Procesando datos..." crlf)
    (focus procesado-datos)
)



;;; MODULO DE SELECCIÓN

(deffacts procesado-datos::hechos-iniciales
    (obras_seleccionadas nil)
    (valorar-conocimiento nil)
    (valorar-autor nil)
    (valorar-epoca nil)
    (valorar-estilo nil)
    (valorar-tematica nil)
    (valorar-relevancia nil)
    (lista-obras-visita)
)

(defrule procesado-datos::añadir_todas_las_obras
    ?hecho <- (obras_seleccionadas nil)
    =>
	(bind $?lista (find-all-instances ((?inst ObraDeArte)) TRUE))
	(progn$ (?curr-con ?lista)
		(make-instance (gensym) of Recomendacion (nombre_obra ?curr-con)(puntuacion 0))
	)	
    (retract ?hecho)
)

(defrule procesado-datos::valorar-nivel-complejidad
    (datos_grupo (nivel ?nivel))
    ?rec <- (object (is-a Recomendacion) (nombre_obra ?conta) (puntuacion ?p) (justificaciones $?just))
	?cont <-(object (is-a ObraDeArte) (relevancia ?relevancia) (complejidad ?complejidad))
    ?hecho <- (valorar-conocimiento nil)
    (test (eq (instance-name ?cont) (instance-name ?conta)))
    (test (eq ?p 0))
    =>
    (bind ?com 0)
    (if (eq ?complejidad "Muy baja")
        then (bind ?com 1)
    )
    (if (eq ?complejidad "Baja")
        then (bind ?com 2)
    )   
    (if (eq ?complejidad "Media-baja")
        then (bind ?com 3)
    )
    (if (eq ?complejidad "Media")
        then (bind ?com 5)
    )
    (if (eq ?complejidad "Media-alta")
        then (bind ?com 8)
    )
    (if (eq ?complejidad "Alta")
        then (bind ?com 9)
    )
    (if (eq ?complejidad "Muy Alta")
        then (bind ?com 10)
    )
    (if (>= ?nivel ?com)
        then (bind ?p 100)
    )
    (if (< ?nivel ?com)
        then (bind ?p 0)
    )
    (send ?rec put-puntuacion ?p)
    (printout t ?com " " ?nivel " " ?p crlf)
)

(defrule procesado-datos::valorar-autor
    (preferencias_grupo (autor_favorito ?autor))
    ?rec <- (object (is-a Recomendacion) (nombre_obra ?conta) (puntuacion ?p) (justificaciones $?just))
    ?cont <-(object (is-a ObraDeArte))
    ?hecho <- (valorar-autor nil)
    (test (eq (instance-name ?cont) (instance-name ?conta)))
    =>
    (bind $?cuadros (send ?autor get-autor_de))
    (bind ?p 0)
    (if (member$ ?conta $?cuadros) then 
        (bind ?p 100)
        (printout t "Autor " ?p crlf)
    )
    (send ?rec put-puntuacion ?p)
    (printout t ?p crlf)
)


(defrule procesado-datos::valorar-epoca
    (preferencias_grupo (epoca_favorita ?epoca))
    ?rec <- (object (is-a Recomendacion) (nombre_obra ?conta) (puntuacion ?p) (justificaciones $?just))
    ?cont <-(object (is-a ObraDeArte))
    ?hecho <- (valorar-epoca nil)
    (test (eq (instance-name ?cont) (instance-name ?conta)))
    =>
    (bind ?p 0)
    (if (eq ?epoca (send ?cont get-tiene_epoca))
        then (bind ?p 100)
    )
    (send ?rec put-puntuacion ?p)
    (printout t ?p crlf)
)

(defrule procesado-datos::valorar-estilo
    (preferencias_grupo (estilo_favorito ?estilo))
    ?rec <- (object (is-a Recomendacion) (nombre_obra ?conta) (puntuacion ?p) (justificaciones $?just))
    ?cont <-(object (is-a ObraDeArte))
    ?hecho <- (valorar-estilo nil)
    (test (eq (instance-name ?cont) (instance-name ?conta)))
    =>
    (bind ?p 0)
    (if (eq ?estilo (send ?cont get-tiene_estilo))
        then (bind ?p 100)
    )
    (send ?rec put-puntuacion ?p)
    (printout t ?p crlf)
)

(defrule procesado-datos::valorar-tematica
    (preferencias_grupo (tematica_favorita ?tematica))
    ?rec <- (object (is-a Recomendacion) (nombre_obra ?conta) (puntuacion ?p) (justificaciones $?just))
    ?cont <-(object (is-a ObraDeArte))
    ?hecho <- (valorar-tematica nil)
    (test (eq (instance-name ?cont) (instance-name ?conta)))
    =>
    (bind ?p 0)
    (if (eq ?tematica (send ?cont get-tema))
        then (bind ?p 100)
    )
    (send ?rec put-puntuacion ?p)
    (printout t ?p crlf)
)

(defrule procesado-datos::valorar-relevancia
    ?rec <- (object (is-a Recomendacion) (nombre_obra ?conta) (puntuacion ?p) (justificaciones $?just))
    ?cont <-(object (is-a ObraDeArte) (relevancia ?relevancia))
    ?hecho <- (valorar-relevancia nil)
    (test (eq (instance-name ?cont) (instance-name ?conta)))
    =>
    (bind ?p 0)
    (if (eq ?relevancia "Muy baja")
        then (bind ?p 1)
    )
    (if (eq ?relevancia "Baja")
        then (bind ?p 2)
    )   
    (if (eq ?relevancia "Media-baja")
        then (bind ?p 3)
    )
    (if (eq ?relevancia "Media")
        then (bind ?p 5)
    )
    (if (eq ?relevancia "Media-alta")
        then (bind ?p 8)
    )
    (if (eq ?relevancia "Alta")
        then (bind ?p 9)
    )
    (if (eq ?relevancia "Muy Alta")
        then (bind ?p 10)
    )
    (send ?rec put-puntuacion ?p)
    (printout t ?p crlf)
)

;;; MODULO DE IMPRESION DE RESULTADOS

(deffacts resultados_al_grupo::hechos-iniciales
    (mostrar_resultados nil)
)


(defrule resultados_al_grupo::imprimir-resultados
    (lista-obras-visita (recomendaciones $?lista))
    ?hecho <- (mostrar_resultados nil)
    =>
    (printout t "Las obras seleccionadas para su visita son: " crlf)
    (printout t "----------------------------------------------" crlf)
    (loop-for-count (?i 1 (length$ $?lista)) do
        (bind ?curr-obj (nth$ ?i $?lista))
        (printout t "Cuadro " ?i ": "  (send ?curr-obj get-nombre) crlf)
    )
    (printout t "----------------------------------------------" crlf)
    (retract ?hecho)
)