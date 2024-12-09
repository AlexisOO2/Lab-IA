;;; ---------------------------------------------------------
;;; ontology.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontology.ttl
;;; :Date 09/12/2024 16:17:45

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
    ;;; El tema de una obra de arte está relacionada a una cierta temática
    (multislot tema
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Una obra de arte o un pintor tienen una cierta época o estilo
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
    ;;; Una obra de arte o un pintor tienen una cierta época o estilo
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
    ([Chica_ante_el_espejo] of ObraDeArte
         (tema  [Sentimental])
         (tiene  [Epoca_Modernismo] [Estilo_Surrealista])
         (año_de_creacion  1932)
         (complejidad  "Media-alta")
         (dimensiones  "1.62x1.30")
         (nombre  "Chica ante el espejo")
         (relevancia  "Alta")
    )

    ([Claude_Monet] of Pintor
         (autor_de  [Impresión_Sol_Naciente] [Los_Nenúfares])
         (tiene  [Epoca_Impresionismo] [Estilo_Impresionista])
         (nacionalidad  "Francesa")
         (nombre  "Claude Monet")
    )

    ([El_sueño] of ObraDeArte
         (tema  [Sueño])
         (tiene  [Epoca_Modernismo] [Estilo_Surrealista])
         (año_de_creacion  1932)
         (complejidad  "Media")
         (dimensiones  "1.3x0.97")
         (nombre  "El sueño")
         (relevancia  "Alta")
    )

    ([El_viejo_guitarrista] of ObraDeArte
         (tema  [Música])
         (tiene  [Epoca_Modernismo] [Estilo_Surrealista])
         (año_de_creacion  1903)
         (complejidad  "Media-alta")
         (dimensiones  "1.2x0.8")
         (nombre  "El viejo guitarrista")
         (relevancia  "Alta")
    )

    ;;; Epoca del Impresionismo
    ([Epoca_Impresionismo] of Epoca
         (nombre  "Impresionismo")
    )

    ;;; Epoca del Modernismo
    ([Epoca_Modernismo] of Epoca
         (nombre  "Modernismo")
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

    ;;; Estilo Surrealista
    ([Estilo_Surrealista] of Estilo
         (nombre  "Surrealista")
    )

    ;;; Tema familia
    ([Familia] of Tematica
         (nombre  "Familia")
    )

    ([Guernica] of ObraDeArte
         (tema  [Guerra])
         (tiene  [Epoca_Modernismo] [Estilo_Surrealista])
         (año_de_creacion  1937)
         (complejidad  "Alta")
         (dimensiones  "3.5x7.8")
         (nombre  "Guernica")
         (relevancia  "Alta")
    )

    ;;; Tema guerra
    ([Guerra] of Tematica
         (nombre  "Guerra")
    )

    ([Impresión_Sol_Naciente] of ObraDeArte
         (tema  [Paisaje])
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

    ([La_familia_de_saltimbanquis] of ObraDeArte
         (tema  [Familia])
         (tiene  [Epoca_Modernismo] [Estilo_Surrealista])
         (año_de_creacion  1905)
         (complejidad  "Media-alta")
         (dimensiones  "2.13x2.3")
         (nombre  "La familia de saltimbanquis")
         (relevancia  "Alta")
    )

    ([La_mujer_que_llora] of ObraDeArte
         (tema  [Sentimental])
         (tiene  [Epoca_Modernismo] [Estilo_Surrealista])
         (año_de_creacion  1937)
         (complejidad  "Media-alta")
         (dimensiones  "0.61x0.50")
         (nombre  "La mujer que llora")
         (relevancia  "Media-alta")
    )

    ([La_Última_Cena] of ObraDeArte
         (tema  [Religión])
         (tiene  [Epoca_Renacimiento] [Estilo_Renacentista])
         (año_de_creacion  1495)
         (complejidad  "Muy alta")
         (dimensiones  "460x880")
         (nombre  "La Última Cena")
         (relevancia  "Alta")
    )

    ([Las_señoritas_de_Avignon] of ObraDeArte
         (tema  [Retrato])
         (tiene  [Epoca_Modernismo] [Estilo_Surrealista])
         (año_de_creacion  1907)
         (complejidad  "Alta")
         (dimensiones  "2.4x2.3")
         (nombre  "Las señoritas de Avignon")
         (relevancia  "Alta")
    )

    ([Leonardo_da_Vinci] of Pintor
         (autor_de  [La_Última_Cena] [Mona_Lisa])
         (tiene  [Epoca_Renacimiento] [Estilo_Renacentista])
         (nacionalidad  "Italiana")
         (nombre  "Leonardo Da Vinci")
    )

    ([Los_Nenúfares] of ObraDeArte
         (tema  [Paisaje])
         (tiene  [Epoca_Impresionismo] [Estilo_Impresionista])
         (año_de_creacion  1899)
         (complejidad  "Media")
         (dimensiones  "200x300")
         (nombre  "Los Nenúfares")
         (relevancia  "Media-Alta")
    )

    ([Los_tres_músicos] of ObraDeArte
         (tema  [Música])
         (tiene  [Epoca_Modernismo] [Estilo_Surrealista])
         (año_de_creacion  1921)
         (complejidad  "Alta")
         (dimensiones  "2x2.23")
         (nombre  "Los tres músicos")
         (relevancia  "Alta")
    )

    ([Masacre_en_Corea] of ObraDeArte
         (tema  [Guerra])
         (tiene  [Epoca_Modernismo] [Estilo_Surrealista])
         (año_de_creacion  1951)
         (complejidad  "Media-alta")
         (dimensiones  "1.1x2.1")
         (nombre  "Masacre en Corea")
         (relevancia  "Alta")
    )

    ([Mona_Lisa] of ObraDeArte
         (tema  [Retrato])
         (tiene  [Epoca_Renacimiento] [Estilo_Renacentista])
         (año_de_creacion  1503)
         (complejidad  "Alta")
         (dimensiones  "77x53")
         (nombre  "Mona Lisa")
         (relevancia  "Alta")
    )

    ([Mujer_con_sombrero] of ObraDeArte
         (tema  [Retrato])
         (tiene  [Epoca_Modernismo] [Estilo_Surrealista])
         (año_de_creacion  1935)
         (complejidad  "Media-alta")
         (dimensiones  "0.61x0.5")
         (nombre  "Mujer con sombrero")
         (relevancia  "Media-alta")
    )

    ([Museo_de_Arte_Universal] of Museo
         (formado_por  [Sala_Impresionismo] [Sala_Picasso] [Sala_Renacimiento])
         (nombre  "Museo de Arte Universal")
    )

    ;;; Tema música
    ([Música] of Tematica
         (nombre  "Música")
    )

    ([Pablo_Picasso] of Pintor
         (autor_de  [Chica_ante_el_espejo] [El_sueño] [Guernica] [La_familia_de_saltimbanquis] [La_mujer_que_llora] [Las_señoritas_de_Avignon] [Los_tres_músicos] [Masacre_en_Corea] [Mujer_con_sombrero])
         (tiene  [Epoca_Modernismo] [Estilo_Surrealista])
         (nacionalidad  "Español")
         (nombre  "Pablo Picasso")
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

    ([Sala_Picasso] of Sala
         (contiene  [Chica_ante_el_espejo] [El_sueño] [Guernica] [La_familia_de_saltimbanquis] [La_mujer_que_llora] [Las_señoritas_de_Avignon] [Los_tres_músicos] [Masacre_en_Corea] [Mujer_con_sombrero])
         (nombre  "Sala Pablo Picasso")
    )

    ([Sala_Renacimiento] of Sala
         (contiene  [La_Última_Cena] [Mona_Lisa])
         (nombre  "Sala de Renacimiento")
    )

    ;;; Tema sentimental
    ([Sentimental] of Tematica
         (nombre  "Sentimental")
    )

    ;;; Tema sueño
    ([Sueño] of Tematica
         (nombre  "Sueño")
    )

)
