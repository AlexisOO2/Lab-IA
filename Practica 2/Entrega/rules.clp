(defclass Recomendacion 
	(is-a USER)
	(role concrete)
    (slot nombre_obra
		(type INSTANCE)
		(create-accessor read-write))
    (slot puntuacion
        (type INTEGER)
        (create-accessor read-write))
    (slot duracion-vista
        (type INTEGER)
        (create-accessor read-write)
        (default 0)
    )
    (slot sala
        (type INSTANCE)
        (create-accessor read-write)
    )
    (slot dia
        (type INTEGER)
        (create-accessor read-write)
        (default 0)
    )
    (slot valorada
        (type SYMBOL)
        (default FALSE))
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
	(slot nivel (type INTEGER)(default 5)) ;conocimiento
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

;;; Template para una lista de recomendaciones con orden
(deftemplate MAIN::lista-rec-ordenada
	(multislot recomendaciones (type INSTANCE))
)

;;; Template para una lista de recomendaciones ordenadas por sala
(deftemplate MAIN::lista-rec-salas
	(multislot recomendaciones (type INSTANCE))
)

;;; Template para una lista de las mejores recomendaciones
(deftemplate MAIN::lista-rec-mejores
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

(deffunction maximo-puntuacion ($?lista)
	(bind ?maximo -1)
	(bind ?elemento nil)
	(progn$ (?curr-rec $?lista)
		(bind ?curr-cont (send ?curr-rec get-nombre_obra))
		(bind ?curr-punt (send ?curr-rec get-puntuacion))
		(if (> ?curr-punt ?maximo)
			then 
			(bind ?maximo ?curr-punt)
			(bind ?elemento ?curr-rec)
		)
	)
	?elemento
)

;;; ---------------------------------------------------------
;;;                     REGLAS
;;; ---------------------------------------------------------

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



;;; MODULO DE PREGUNTAS

(defrule recopilacion-usuario::establecer-tamanyo-grupo
    (not (datos_grupo))
	=>
	(bind ?tamanyo (pregunta-numerica "¿De cuantos visitantes esta formado el grupo? " 1 20))
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
    (test (eq ?nivel 5))
    =>
    (bind ?res (pregunta-numerica "Cual dirias que es tu nivel de conocimiento sobre el arte?" 1 5))
    (bind ?nivel (+ ?nivel ?res))
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



;;; MODULO DE PROCESADO DE DATOS

(deffacts procesado-datos::hechos-iniciales
    (obras_seleccionadas nil)
    (pasar_generacion nil)
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
    (declare (salience 10))
    (datos_grupo (nivel ?nivel))
    (datos_grupo (tamanyo ?tamanyo))
    (preferencias_grupo (autor_favorito ?autor))
    (preferencias_grupo (epoca_favorita ?epoca))
    (preferencias_grupo (estilo_favorito ?estilo))
    (preferencias_grupo (tematica_favorita ?tematica))
    ?rec <- (object (is-a Recomendacion) (nombre_obra ?conta) (puntuacion ?p) (valorada ?v) (duracion-vista ?t))
	?cont <-(object (is-a ObraDeArte) (relevancia ?relevancia) (complejidad ?complejidad) (tiene_epoca ?epoca_obra))
    (test (eq (instance-name ?cont) (instance-name ?conta)))
    (test (eq ?v FALSE))
    =>
    (bind ?epoca_obra (send ?cont get-tiene_epoca))
    (bind ?estilo_obra (send ?cont get-tiene_estilo))
    (bind ?tematica_obra (send ?cont get-tema))
    (bind $?lista_salas (find-all-instances ((?inst Sala)) TRUE))
    (loop-for-count (?i 1 (length$ $?lista_salas)) do
        (bind ?obras_salas (send (nth$ ?i $?lista_salas) get-contiene))
        (if (member$ ?conta ?obras_salas)
            then (send ?rec put-sala (nth$ ?i $?lista_salas))
        )
    )
    ;;Complejidad
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
    (if (< ?nivel ?com)
        then (unmake-instance ?rec)
    )
    (if (>= ?nivel ?com)
        then (bind ?p 100)
        ;;Autor
        (bind $?cuadros (send ?autor get-autor_de))
        (if (member$ ?conta $?cuadros) then 
            (bind ?p (+ ?p 100))
        )
        ;;Epoca
        (if (eq ?epoca ?epoca_obra)
            then (bind ?p (+ ?p 100))
        )
        ;;Estilo
        (if (eq ?estilo ?estilo_obra)
            then (bind ?p (+ ?p 100))
        )
        ;;Tematica
        (if (eq ?tematica ?tematica_obra)
            then (bind ?p (+ ?p 100))
        )
        ;;Relevancia
        (if (eq ?relevancia "Muy baja")
            then (bind ?p (* ?p 1))
        )
        (if (eq ?relevancia "Baja")
            then (bind ?p (* ?p 2))
        )   
        (if (eq ?relevancia "Media-baja")
            then (bind ?p (* ?p 3))
        )
        (if (eq ?relevancia "Media")
            then (bind ?p (* ?p 5))
        )
        (if (eq ?relevancia "Media-alta")
            then (bind ?p (* ?p 8))
        )
        (if (eq ?relevancia "Alta")
            then (bind ?p (* ?p 9))
        )
        (if (eq ?relevancia "Muy Alta")
            then (bind ?p (* ?p 10))
        )
        ;;Tiempo
        (bind ?t (+ 2 (* 2 (/ (* ?com ?tamanyo) 5))))
        (send ?rec put-duracion-vista ?t)
        (send ?rec put-puntuacion ?p)
        (send ?rec put-valorada TRUE)
    )
)
(defrule procesado-datos::pasar-generacion
    (declare (salience -1))
    ?hecho <- (pasar_generacion nil)
    =>
    (retract ?hecho)
    (focus generacion_soluciones)
)

;;; MODULO DE SELECCION DE OBRAS
(deffacts generacion_soluciones::hechos-iniciales
    (obras-seleccionadas nil)
    (obras-ordenadas-puntuacion nil)
    (obras-ordenadas-salas nil)
    (obras-seleccionadas-tiempo nil)
    (anadidr-tiempo nil)
    (lista-obras-visita)
    (lista-rec-salas)
)

(defrule generacion_soluciones::seleccionar-obras
    (declare (salience 10))
    ?hecho <- (obras-seleccionadas nil)
    =>
    (printout t "Seleccionando las obras para su visita..." crlf)
    (bind ?lista (find-all-instances ((?inst Recomendacion)) TRUE))
    (assert (lista-obras-visita (recomendaciones ?lista)))
    (retract ?hecho)
)

(defrule generacion_soluciones::crea-lista-ordenada "Se crea una lista ordenada de contenido"
    (declare (salience 5))
    (not (lista-rec-ordenada))
	(lista-obras-visita (recomendaciones $?lista))
    ?hecho <- (obras-ordenadas-puntuacion nil)
	=>
	(bind $?resultado (create$ ))
	(while (not (eq (length$ $?lista) 0))  do
		(bind ?curr-rec (maximo-puntuacion $?lista))
		(bind $?lista (delete-member$ $?lista ?curr-rec))
		(bind $?resultado (insert$ $?resultado (+ (length$ $?resultado) 1) ?curr-rec))
	)
	(assert (lista-rec-ordenada (recomendaciones $?resultado)))
    (printout t "Ordenando obras de arte..." crlf)
    (loop-for-count (?i 1 (length$ $?resultado)) do
        (bind ?curr-obj (nth$ ?i $?resultado))
    )
    (retract ?hecho)
)

(defrule generacion_soluciones::selccionar-mejores-obras
    (declare (salience 4))
    ?hecho <- (obras-seleccionadas-tiempo nil)
    (lista-rec-ordenada (recomendaciones $?lista))
    ?g <- (datos_grupo (dias ?dias) (horasdia ?horasdia)) 
    =>
    (bind ?resultado (create$ ))
    (bind ?tiempo_total 0)
    (bind ?tiempo_max (* (* ?horasdia 60) ?dias))
    (bind $?lista_aux_salas (create$ ))
    (loop-for-count (?i 1 (length$ $?lista)) do
        (bind ?curr-obj (nth$ ?i $?lista))
        (bind ?tiempo_total (+ ?tiempo_total (send ?curr-obj get-duracion-vista)))
        (if (<= ?tiempo_total ?tiempo_max)
            then (bind ?resultado (insert$ ?resultado (+ (length$ ?resultado) 1) ?curr-obj))
            (if (not (member$ (send ?curr-obj get-sala) $?lista_aux_salas)) then 
                (bind $?lista_aux_salas (insert$ $?lista_aux_salas (+ (length$ $?lista_aux_salas) 1) (send ?curr-obj get-sala)))
                (bind ?tiempo_total (+ ?tiempo_total 2))
            )
        )
    )
    (assert (lista-rec-mejores (recomendaciones ?resultado)))
    (retract ?hecho)
)


(defrule generacion_soluciones::ordenar-salas
    (declare (salience 3))
    (lista-rec-mejores (recomendaciones $?lista))
    ?hecho <- (obras-ordenadas-salas nil)
    =>
    (bind ?lista_salas (find-all-instances ((?inst Sala)) TRUE))
    (bind ?resultado (create$ ))
    (loop-for-count (?i 1 (length$ ?lista_salas)) do
        (bind ?curr-sala (nth$ ?i ?lista_salas))
        (loop-for-count (?j 1 (length$ $?lista)) do
            (bind ?curr-obj (nth$ ?j $?lista))
            (bind ?curr-obra (send ?curr-obj get-nombre_obra))
            (bind ?sala-obra (send ?curr-obj get-sala))
            (if (eq ?sala-obra ?curr-sala) then 
                (bind ?resultado (insert$ ?resultado (+ (length$ ?resultado) 1) ?curr-obj))
            )
        )
    )
    (assert (lista-rec-salas (recomendaciones ?resultado)))
    (retract ?hecho)

)

(defrule generacion_soluciones::anadir-tiempo
    (declare (salience 2))
    ?g <- (datos_grupo (dias ?dias) (horasdia ?horasdia))
    ?hecho <- (anadidr-tiempo nil)
    (lista-rec-salas (recomendaciones $?lista))
    =>
    (bind ?tiempo_total 0)
    (bind ?horasdia (* ?horasdia 60))
    (bind ?dia 1)
    (loop-for-count (?i 1 (length$ $?lista)) do
        (bind ?curr-obj (nth$ ?i $?lista))
        (bind ?tiempo_total (+ ?tiempo_total (send ?curr-obj get-duracion-vista)))
        (if (>= ?tiempo_total ?horasdia) then
            (bind ?tiempo_total 0)
            (bind ?dia (+ ?dia 1))
        )
        (if (> ?dia ?dias) then
            (break)
        )
        (send ?curr-obj put-dia ?dia)
    )
    (retract ?hecho)
    (focus resultados_al_grupo)
)

;;; MODULO DE IMPRESION DE RESULTADOS

(deffacts resultados_al_grupo::hechos-iniciales
    (mostrar_resultados nil)
)


(defrule resultados_al_grupo::imprimir-resultados
    (lista-rec-salas (recomendaciones $?lista))
    ?hecho <- (mostrar_resultados nil)
    =>
    (printout t "Las obras seleccionadas para su visita son según el día son: " crlf)
    (loop-for-count (?i 1 5) do
        (printout t "-------------------- Dia " ?i " ----------------------" crlf)
        (loop-for-count (?j 1 (length$ $?lista)) do
            (bind ?curr-obj (nth$ ?j $?lista))
            (if (eq ?i (send ?curr-obj get-dia)) then
                (printout t "Obra: " (send (send ?curr-obj get-nombre_obra) get-nombre) crlf)
                (printout t "Sala: " (send (send ?curr-obj get-sala) get-nombre) crlf)
                (printout t "Duracion: " (send ?curr-obj get-duracion-vista) " minutos" crlf)
                (printout t crlf)
            )
        )

    )
    (printout t "----------------------------------------------" crlf)
    (retract ?hecho)
)