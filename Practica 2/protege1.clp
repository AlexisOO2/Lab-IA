;;; ---------------------------------------------------------
;;; protege1.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology protege1.ttl
;;; :Date 27/11/2024 10:31:29

(defclass Museo "Esta clase respresenta un museo"
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Un museo tiene salas y una sala tiene obras de arte
    (slot tiene
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
    ;;; Un museo tiene salas y una sala tiene obras de arte
    (slot tiene
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
    ;;; Un pintor pinta obras de arte
    (slot pinta
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
    ;;; En una visita se recorren varias salas
    (slot recorre
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
         (pinta  [Impresión_Sol_Naciente] [Los_Nenúfares])
         (epoca  "Impresionismo")
         (estilo  "Impresionismo")
         (nacionalidad  "Francesa")
         (nombre  "Claude Monet")
    )

    ([Impresionismo] of Sala
         (tiene  [Impresión_Sol_Naciente] [Los_Nenúfares])
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
         (pinta  [La_Última_Cena] [Mona_Lisa])
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
         (tiene  [Impresionismo] [Renacimiento])
         (nombre  "Museo de Arte Universal")
    )

    ([Renacimiento] of Sala
         (tiene  [La_Última_Cena] [Mona_Lisa])
         (nombre  "Sala de Renacimiento")
    )

)
