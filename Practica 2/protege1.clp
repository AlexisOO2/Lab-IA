;;; ---------------------------------------------------------
;;; protege1.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology protege1.ttl
;;; :Date 30/11/2024 22:40:22

(defclass Museo "Esta clase respresenta un museo"
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

(defclass Sala "Esta clase respresenta una sala"
    (is-a Museo)
    (role concrete)
    (pattern-match reactive)
    ;;; Una Sale contiene una serie de Obras de Arte
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

(defclass ObraDeArte "Esta clase respresenta una obra de arte"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot año_de_creacion
        (type INTEGER)
        (create-accessor read-write))
    (slot complejidad
        (type INTEGER)
        (create-accessor read-write))
    (slot dimensiones
        (type INTEGER)
        (create-accessor read-write))
    (slot epoca
        (type STRING)
        (create-accessor read-write))
    (slot estilo
        (type STRING)
        (create-accessor read-write))
    (slot nombre
        (type STRING)
        (create-accessor read-write))
    (slot relevancia
        (type FLOAT)
        (create-accessor read-write))
    (slot tematica
        (type STRING)
        (create-accessor read-write))
)

(defclass Pintor "Esta clase respresenta un pintor"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Un Pintor es el autor de una Obra de Arte
    (multislot autor_de
        (type INSTANCE)
        (create-accessor read-write))
    (slot epoca
        (type STRING)
        (create-accessor read-write))
    (slot estilo
        (type STRING)
        (create-accessor read-write))
    (slot nacionalidad
        (type STRING)
        (create-accessor read-write))
    (slot nombre
        (type STRING)
        (create-accessor read-write))
)

(defclass Visita "Esta clase respresenta una visita"
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

(defclass Visitante "Esta clase respresenta un visitante"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Un usuario tiene preferencia por un Autor u Obras de Arte
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
    (multislot preferencias
        (type STRING)
        (create-accessor read-write))
    (slot tipo
        (type STRING)
        (create-accessor read-write))
)

(definstances instances
    ([Claude_Monet] of Pintor
         (epoca  "Impresionismo")
         (estilo  "Impresionismo")
         (nacionalidad  "Francesa")
         (nombre  "Claude Monet")
    )

    ([Impresionismo] of Sala
         (nombre  "Sala de Impresionismo")
    )

    ([Impresión_Sol_Naciente] of ObraDeArte
         (año_de_creacion  1872)
         (complejidad  "media")
         (dimensiones  "48x63")
         (epoca  "Impresionismo")
         (estilo  "Impresionismo")
         (nombre  "Impresion Sol Naciente")
         (relevancia  "alta")
         (tematica  "Paisaje")
    )

    ([Juan] of Visitante
         (conocimiento_de_arte  "medio-alto")
         (nombre  "Juan")
         (preferencias  "Renacimiento
Leonardo Da Vinci")
         (tipo  "persona")
    )

    ([La_Última_Cena] of ObraDeArte
         (año_de_creacion  1495)
         (complejidad  "Muy alta")
         (dimensiones  "460x880")
         (epoca  "Renacimiento")
         (estilo  "Renacimiento")
         (nombre  "La Última Cena")
         (relevancia  "Alta")
         (tematica  "Religiosa")
    )

    ([Leonardo_da_Vinci] of Pintor
         (epoca  "Renacimiento")
         (estilo  "Renacimiento")
         (nacionalidad  "Italiana")
         (nombre  "Leonardo Da Vinci")
    )

    ([Los_Nenúfares] of ObraDeArte
         (año_de_creacion  1899)
         (complejidad  "Media")
         (dimensiones  "200x300")
         (epoca  "Impresionismo")
         (estilo  "Impresionismo")
         (nombre  "Los Nenúfares")
         (relevancia  "Media-Alta")
         (tematica  "Naturaleza")
    )

    ([Mona_Lisa] of ObraDeArte
         (año_de_creacion  1503)
         (complejidad  "Alta")
         (dimensiones  "77x53")
         (epoca  "Renacimiento")
         (estilo  "Renacimiento")
         (nombre  "Mona Lisa")
         (relevancia  "Alta")
         (tematica  "Retrato")
    )

    ([Museo_de_Arte_Universal] of Museo
         (nombre  "Museo de Arte Universal")
    )

    ([Renacimiento] of Sala
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

;;; Modulo de recopilacion del conocimiento del usuario
(defmodule recopilacion-conocimiento
	(import MAIN ?ALL)
    (import recopilacion-usuario deftemplate ?ALL)
	(import recopilacion-prefs deftemplate ?ALL)
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
	(multislot autores_favoritos (type INSTANCE))
	(multislot tematicas_obras_fav (type INSTANCE))
	(multislot estilos_favoritos (type INSTANCE))
	(multislot epocas_favoritas (type INSTANCE))
)

;;; Template para una lista de las obras que se van a visitar
(deftemplate MAIN::lista-obras-visita
	(multislot recomendaciones (type INSTANCE))
)



;;; ---------------------------------------------------------
;;;                     MENSAJES
;;; ---------------------------------------------------------

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

;; (defrule recopilacion-usuario::establecer-tiempo-visita
;;     ()
;;     =>
;;     ()
;; )

;; (defrule recopilacion-prefs::establecer-autor-preferido
;;     ()
;;     =>
;;     ()
;; )

;; (defrule recopilacion-prefs::establecer-obra-preferida
;;     ()
;;     =>
;;     ()
;; )

;; (defrule recopilacion-conocimiento::establecer-nivel-conocimiento
;;     ()
;;     =>
;;     ()
;; )




;;; MODULO DE SELECCIÓN


;;; MODULO DE CONSTRUCCIÓN


;;; MODULO DE IMPRESION DE RESULTADOS


