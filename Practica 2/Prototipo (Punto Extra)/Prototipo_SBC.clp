;;; ---------------------------------------------------------
;;; protege1.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology protege1.ttl
;;; :Date 06/12/2024 19:12:44

(defclass Epoca "Esta clase representa una época"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot nombre
        (type STRING)
        (create-accessor read-write))
)

(defclass Estilo "Esta clase representa un estilo"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot nombre
        (type STRING)
        (create-accessor read-write))
)

(defclass Museo "Esta clase representa un museo"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Un Museo está formado por Salas
    (multislot formado_por
        (type INSTANCE)
        (create-accessor read-write))
    (slot nombre
        (type STRING)
        (create-accessor read-write))
)

(defclass ObraDeArte "Esta clase representa una obra de arte"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot tiene
        (type INSTANCE)
        (create-accessor read-write))
    (multislot topObjectProperty
        (type INSTANCE)
        (create-accessor read-write))
    (slot año_de_creacion
        (type INTEGER)
        (create-accessor read-write))
    (slot complejidad
        (type INTEGER)
        (create-accessor read-write))
    (slot dimensiones
        (type INTEGER)
        (create-accessor read-write))
    (slot nombre
        (type STRING)
        (create-accessor read-write))
    (slot relevancia
        (type FLOAT)
        (create-accessor read-write))
)

(defclass Pintor "Esta clase representa un pintor"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Un Pintor es el autor de una Obra de Arte
    (multislot autor_de
        (type INSTANCE)
        (create-accessor read-write))
    (multislot tiene
        (type INSTANCE)
        (create-accessor read-write))
    (slot nacionalidad
        (type STRING)
        (create-accessor read-write))
    (slot nombre
        (type STRING)
        (create-accessor read-write))
)

(defclass Sala "Esta clase representa una sala"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Una Sala contiene una serie de Obras de Arte
    (multislot contiene
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Dos salas son contiguas
    (multislot contiguas
        (type INSTANCE)
        (create-accessor read-write))
    (slot nombre
        (type STRING)
        (create-accessor read-write))
)

(defclass Tematica "Esta clase representa una temática"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot nombre
        (type STRING)
        (create-accessor read-write))
)

(defclass Visita "Esta clase representa una visita"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; En una Visita se contemplan Obras de Arte
    (multislot contemplan
        (type INSTANCE)
        (create-accessor read-write))
    ;;; En una visita se recorren varias salas
    (multislot recorre
        (type INSTANCE)
        (create-accessor read-write))
    (slot duracion_dias
        (type INTEGER)
        (create-accessor read-write))
    (slot duracion_horas
        (type FLOAT)
        (create-accessor read-write))
    (slot ruta
        (type STRING)
        (create-accessor read-write))
)

(defclass Visitante "Esta clase representa un visitante"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Un usuario tiene preferencia por un Pintor u Obras de Arte
    (multislot prefiere
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Un visitante realiza una visita
    (slot realiza
        (type INSTANCE)
        (create-accessor read-write))
    (slot conocimiento_de_arte
        (type INTEGER)
        (create-accessor read-write))
    (slot nombre
        (type STRING)
        (create-accessor read-write))
    (slot tipo
        (type STRING)
        (create-accessor read-write))
)

(definstances instances
    ([Claude_Monet] of Pintor
         (autor_de  [Impresión_Sol_Naciente] [Los_Nenúfares])
         (tiene  [Epoca_Impresionismo] [Estilo_Impresionista])
         (nacionalidad  "Francesa")
         (nombre  "Claude Monet")
    )

    ;;; Epoca del Impresionismo
    ([Epoca_Impresionismo] of Epoca
         (nombre  "Impresionismo")
    )

    ;;; Epoca del Renacimiento
    ([Epoca_Renacimiento] of Epoca
         (nombre  "Renacimiento")
    )

    ;;; Estilo Impresionista
    ([Estilo_Impresionista] of Estilo
         (nombre  "Impresionista")
    )

    ;;; Estilo Renacentista
    ([Estilo_Renacentista] of Estilo
         (nombre  "Renacentista")
    )

    ([Impresión_Sol_Naciente] of ObraDeArte
         (tiene  [Epoca_Impresionismo] [Estilo_Impresionista])
         (año_de_creacion  1872)
         (complejidad  "media")
         (dimensiones  "48x63")
         (nombre  "Impresion Sol Naciente")
         (relevancia  "alta")
    )

    ([Juan] of Visitante
         (prefiere  [Epoca_Renacimiento] [Leonardo_da_Vinci])
         (conocimiento_de_arte  "medio-alto")
         (nombre  "Juan")
         (tipo  "persona")
    )

    ([La_Última_Cena] of ObraDeArte
         (tiene  [Epoca_Renacimiento] [Estilo_Renacentista])
         (año_de_creacion  1495)
         (complejidad  "Muy alta")
         (dimensiones  "460x880")
         (nombre  "La Última Cena")
         (relevancia  "Alta")
    )

    ([Leonardo_da_Vinci] of Pintor
         (autor_de  [La_Última_Cena] [Mona_Lisa])
         (tiene  [Epoca_Renacimiento] [Estilo_Renacentista])
         (nacionalidad  "Italiana")
         (nombre  "Leonardo Da Vinci")
    )

    ([Los_Nenúfares] of ObraDeArte
         (tiene  [Epoca_Impresionismo] [Estilo_Impresionista])
         (año_de_creacion  1899)
         (complejidad  "Media")
         (dimensiones  "200x300")
         (nombre  "Los Nenúfares")
         (relevancia  "Media-Alta")
    )

    ([Mona_Lisa] of ObraDeArte
         (tiene  [Epoca_Renacimiento] [Estilo_Renacentista])
         (año_de_creacion  1503)
         (complejidad  "Alta")
         (dimensiones  "77x53")
         (nombre  "Mona Lisa")
         (relevancia  "Alta")
    )

    ([Museo_de_Arte_Universal] of Museo
         (formado_por  [Sala_Impresionismo] [Sala_Renacimiento])
         (nombre  "Museo de Arte Universal")
    )

    ;;; Tema Naturaleza
    ([Naturaleza] of Tematica
         (nombre  "Naturaleza")
    )

    ;;; Tema paisaje
    ([Paisaje] of Tematica
         (nombre  "Paisaje")
    )

    ;;; Tema religión
    ([Religión] of Tematica
         (nombre  "Religión")
    )

    ;;; Tema retrato
    ([Retrato] of Tematica
         (nombre  "Retrato")
    )

    ([Sala_Impresionismo] of Sala
         (contiene  [Impresión_Sol_Naciente] [Los_Nenúfares])
         (contiguas  [Sala_Renacimiento])
         (nombre  "Sala de Impresionismo")
    )

    ([Sala_Renacimiento] of Sala
         (contiene  [La_Última_Cena] [Mona_Lisa])
         (nombre  "Sala de Renacimiento")
    )

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
    (bind ?nivel (pregunta-numerica "Cual dirias que es vuestro nivel de conocimiento sobre el arte?" 0 10))
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
    (lista-obras-visita)
)

;;; ejemplo para mostrar los cuadros
(defrule procesado-datos::añadir_cuadros
;;de momento solo haremos que añada el el cuadro preferido y aquel de su autor favorito que cumpla con sus preferencias
    ?g <- (lista-obras-visita (recomendaciones $?l))
    ?hecho <- (obras_seleccionadas nil)
    ?autor_favorito <- (preferencias_grupo (autor_favorito ?autor))
    ?obra_favorita <- (preferencias_grupo (obra_favorita ?obra))
    ?tematica_favorita <- (preferencias_grupo (tematica_favorita ?tematica))
    ?epoca_favorita <- (preferencias_grupo (epoca_favorita ?epoca))
    ?estilo_favorito <- (preferencias_grupo (estilo_favorito ?estilo))
    =>
	(bind $?obras (send ?autor get-autor_de))
    (bind $?lista (create$))
    (loop-for-count (?i 1 (length$ $?obras)) do
        (bind ?curr-obj (nth$ ?i $?obras))
        (bind $?caracteristicas (send ?curr-obj get-tiene))
        (bind ?epoca_cuadro (nth$ 1 ?caracteristicas))
        (bind ?estilo_cuadro (nth$ 2 ?caracteristicas))
        (if (and (eq ?epoca_cuadro ?epoca) (eq ?estilo_cuadro ?estilo))
            then (bind ?lista (insert$ ?lista (+ (length$ ?lista) 1) ?curr-obj))
        )
    )
    (if (not (member$ ?obra ?lista))
        then (bind ?lista (insert$ ?lista (+ (length$ ?lista) 1) ?obra))
    )
    (retract ?hecho)
    (modify ?g (recomendaciones $?lista))
    (focus resultados_al_grupo)

)

;;; MODULO DE IMPRESION DE RESULTADOS

(deffacts resultados_al_grupo::hechos-iniciales
    (mostrar_resultados nil)
    (lista-obras-visita)
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