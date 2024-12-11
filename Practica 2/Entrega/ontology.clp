;;; ---------------------------------------------------------
;;; ontology.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology ontology.ttl
;;; :Date 11/12/2024 11:59:27

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
    ;;; Una obra de arte o un pintor tienen una cierta época
    (multislot tiene_epoca
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Una obra de arte o un pintor tienen una cierto estilo
    (multislot tiene_estilo
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
    ;;; Una obra de arte o un pintor tienen una cierta época
    (multislot tiene_epoca
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Una obra de arte o un pintor tienen una cierto estilo
    (multislot tiene_estilo
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
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1932)
         (complejidad  "Media-alta")
         (dimensiones  "1.62x1.30")
         (nombre  "Chica ante el espejo")
         (relevancia  "Alta")
    )

    ([Claude_Monet] of Pintor
         (autor_de  [Impresión_Sol_Naciente] [Los_Nenúfares])
         (tiene_epoca  [Epoca_Impresionismo])
         (tiene_estilo  [Estilo_Impresionista])
         (nacionalidad  "Francesa")
         (nombre  "Claude Monet")
    )

    ([El_sueño] of ObraDeArte
         (tema  [Sueño])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1932)
         (complejidad  "Media")
         (dimensiones  "1.3x0.97")
         (nombre  "El sueño")
         (relevancia  "Alta")
    )

    ([El_viejo_guitarrista] of ObraDeArte
         (tema  [Música])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
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

    ;;; Estilo Expresionismo Abstracto
    ([Estilo_Expresionismo_Abstracto] of Estilo
         (nombre  "Expresionismo Abstracto")
    )

    ;;; Estilo Simbolismo
    ([Estilo_Simbolismo] of Estilo
         (nombre  "Simbolismo")
    )

    ;;; Tema familia
    ([Familia] of Tematica
         (nombre  "Familia")
    )

    ([Guernica] of ObraDeArte
         (tema  [Guerra])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
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
         (tiene_epoca  [Epoca_Impresionismo])
         (tiene_estilo  [Estilo_Impresionista])
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
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1905)
         (complejidad  "Media-alta")
         (dimensiones  "2.13x2.3")
         (nombre  "La familia de saltimbanquis")
         (relevancia  "Alta")
    )

    ([La_mujer_que_llora] of ObraDeArte
         (tema  [Sentimental])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1937)
         (complejidad  "Media-alta")
         (dimensiones  "0.61x0.50")
         (nombre  "La mujer que llora")
         (relevancia  "Media-alta")
    )

    ([La_Última_Cena] of ObraDeArte
         (tema  [Religión])
         (tiene_epoca  [Epoca_Renacimiento])
         (tiene_estilo  [Estilo_Renacentista])
         (año_de_creacion  1495)
         (complejidad  "Muy alta")
         (dimensiones  "460x880")
         (nombre  "La Última Cena")
         (relevancia  "Alta")
    )

    ([Las_señoritas_de_Avignon] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1907)
         (complejidad  "Alta")
         (dimensiones  "2.4x2.3")
         (nombre  "Las señoritas de Avignon")
         (relevancia  "Alta")
    )

    ([Leonardo_da_Vinci] of Pintor
         (autor_de  [La_Última_Cena] [Mona_Lisa])
         (tiene_epoca  [Epoca_Renacimiento])
         (tiene_estilo  [Estilo_Renacentista])
         (nacionalidad  "Italiana")
         (nombre  "Leonardo Da Vinci")
    )

    ([Los_Nenúfares] of ObraDeArte
         (tema  [Paisaje])
         (tiene_epoca  [Epoca_Impresionismo])
         (tiene_estilo  [Estilo_Impresionista])
         (año_de_creacion  1899)
         (complejidad  "Media")
         (dimensiones  "200x300")
         (nombre  "Los Nenúfares")
         (relevancia  "Media-Alta")
    )

    ([Los_tres_músicos] of ObraDeArte
         (tema  [Música])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1921)
         (complejidad  "Alta")
         (dimensiones  "2x2.23")
         (nombre  "Los tres músicos")
         (relevancia  "Alta")
    )

    ([Masacre_en_Corea] of ObraDeArte
         (tema  [Guerra])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1951)
         (complejidad  "Media-alta")
         (dimensiones  "1.1x2.1")
         (nombre  "Masacre en Corea")
         (relevancia  "Alta")
    )

    ([Mona_Lisa] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Renacimiento])
         (tiene_estilo  [Estilo_Renacentista])
         (año_de_creacion  1503)
         (complejidad  "Alta")
         (dimensiones  "77x53")
         (nombre  "Mona Lisa")
         (relevancia  "Alta")
    )

    ([Mujer_con_sombrero] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1935)
         (complejidad  "Media-alta")
         (dimensiones  "0.61x0.5")
         (nombre  "Mujer con sombrero")
         (relevancia  "Media-alta")
    )

    ([Museo_de_Arte_Universal] of Museo
         (formado_por  [Sala_Impresionismo] [Sala_Picasso] [Sala_Renacimiento] [Sala_Dalí] [Sala_Simbolismo] [Sala_Expresionismo] [Sala_Warhol] [Sala_O_Keefe] [Sala_Arte_Urbano])
         (nombre  "Museo de Arte Universal")
    )

    ;;; Tema música
    ([Música] of Tematica
         (nombre  "Música")
    )

    ([Pablo_Picasso] of Pintor
         (autor_de  [Chica_ante_el_espejo] [El_sueño] [El_viejo_guitarrista] [Guernica] [La_familia_de_saltimbanquis] [La_mujer_que_llora] [Las_señoritas_de_Avignon] [Los_tres_músicos] [Masacre_en_Corea] [Mujer_con_sombrero])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
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
         (contiene  [Chica_ante_el_espejo] [El_sueño] [El_viejo_guitarrista] [Guernica] [La_familia_de_saltimbanquis] [La_mujer_que_llora] [Las_señoritas_de_Avignon] [Los_tres_músicos] [Masacre_en_Corea] [Mujer_con_sombrero])
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

    ([Salvador_Dalí] of Pintor
         (autor_de  [La_persistencia_de_la_memoria] [Cristo_de_San_Juan_de_la_Cruz] [Sueño_causado_por_el_vuelo_de_una_abeja] [La_tentación_de_San_Antonio] [El_gran_masturbador] [Cisnes_que_se_reflejan_como_elefantes] [Retrato_de_Mae_West] [Galatea_de_las_esferas] [El_descubrimiento_de_América_por_Cristóbal_Colón] [El_rostro_de_la_guerra])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (nacionalidad  "Español")
         (nombre  "Salvador Dalí")
    )

    ([La_persistencia_de_la_memoria] of ObraDeArte
         (tema  [Paisaje])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1931)
         (complejidad  "Media")
         (dimensiones  "0.24x0.33")
         (nombre  "La persistencia de la memoria")
         (relevancia  "Alta")
    )

    ([Cristo_de_San_Juan_de_la_Cruz] of ObraDeArte
         (tema  [Religión])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1951)
         (complejidad  "Alta")
         (dimensiones  "2.05x1.16")
         (nombre  "Cristo de San Juan de la Cruz")
         (relevancia  "Alta")
    )

    ([Sueño_causado_por_el_vuelo_de_una_abeja] of ObraDeArte
         (tema  [Onírico])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1944)
         (complejidad  "Media-alta")
         (dimensiones  "0.51x0.41")
         (nombre  "Sueño causado por el vuelo de una abeja")
         (relevancia  "Alta")
    )

    ([La_tentación_de_San_Antonio] of ObraDeArte
         (tema  [Religión])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1946)
         (complejidad  "Alta")
         (dimensiones  "0.89x1.19")
         (nombre  "La tentación de San Antonio")
         (relevancia  "Media-alta")
    )

    ([El_gran_masturbador] of ObraDeArte
         (tema  [Psicológico])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1929)
         (complejidad  "Alta")
         (dimensiones  "1.10x0.89")
         (nombre  "El gran masturbador")
         (relevancia  "Alta")
    )

    ([Cisnes_que_se_reflejan_como_elefantes] of ObraDeArte
         (tema  [Metamorfosis])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1937)
         (complejidad  "Media-alta")
         (dimensiones  "0.61x0.65")
         (nombre  "Cisnes que se reflejan como elefantes")
         (relevancia  "Alta")
    )

    ([Retrato_de_Mae_West] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1935)
         (complejidad  "Alta")
         (dimensiones  "0.60x0.60")
         (nombre  "Retrato de Mae West")
         (relevancia  "Media-alta")
    )

    ([Galatea_de_las_esferas] of ObraDeArte
         (tema  [Ciencia])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1952)
         (complejidad  "Alta")
         (dimensiones  "0.65x0.54")
         (nombre  "Galatea de las esferas")
         (relevancia  "Alta")
    )

    ([El_descubrimiento_de_América_por_Cristóbal_Colón] of ObraDeArte
         (tema  [Histórico])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1959)
         (complejidad  "Alta")
         (dimensiones  "4.10x2.90")
         (nombre  "El descubrimiento de América por Cristóbal Colón")
         (relevancia  "Alta")
    )

    ([El_rostro_de_la_guerra] of ObraDeArte
         (tema  [Psicológico])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1940)
         (complejidad  "Media-alta")
         (dimensiones  "0.64x0.79")
         (nombre  "El rostro de la guerra")
         (relevancia  "Alta")
    )

    ;;; Tema onírico
    ([Onírico] of Tematica
         (nombre  "Onírico")
    )

    ;;; Tema psicológico
    ([Psicológico] of Tematica
         (nombre  "Psicológico")
    )

    ;;; Tema metamorfosis
    ([Metamorfosis] of Tematica
         (nombre  "Metamorfosis")
    )

    ;;; Tema ciencia
    ([Ciencia] of Tematica
         (nombre  "Ciencia")
    )

    ;;; Tema histórico
    ([Histórico] of Tematica
         (nombre  "Histórico")
    )

    ([Sala_Dalí] of Sala
         (contiene  [La_persistencia_de_la_memoria] [Cristo_de_San_Juan_de_la_Cruz] [Sueño_causado_por_el_vuelo_de_una_abeja] [La_tentación_de_San_Antonio] [El_gran_masturbador] [Cisnes_que_se_reflejan_como_elefantes] [Retrato_de_Mae_West] [Galatea_de_las_esferas] [El_descubrimiento_de_América_por_Cristóbal_Colón] [El_rostro_de_la_guerra])
         (nombre  "Sala Salvador Dalí")
    )

    ([Frida_Kahlo] of Pintor
         (autor_de  [Las_dos_Fridas] [La_columna_rota] [El_venado_herido] [Viva_la_vida] [Autorretrato_con_collar_de_espinas] [Henry_Ford_Hospital] [Lo_Que_el_Agua_Me_Dio] [El_Abrazo_de_Amor_de_El_Universo] [Mi_Vestido_Cuelga_Allí] [Unos_Cuantos_Piquetitos])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Simbolismo])
         (nacionalidad  "Mexicana")
         (nombre  "Frida Kahlo")
    )

    ([Las_dos_Fridas] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Simbolismo])
         (año_de_creacion  1939)
         (complejidad  "Alta")
         (dimensiones  "1.73x1.74")
         (nombre  "Las dos Fridas")
         (relevancia  "Alta")
    )

    ([La_columna_rota] of ObraDeArte
         (tema  [Sentimental])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Simbolismo])
         (año_de_creacion  1944)
         (complejidad  "Alta")
         (dimensiones  "0.40x0.34")
         (nombre  "La columna rota")
         (relevancia  "Alta")
    )

    ([El_venado_herido] of ObraDeArte
         (tema  [Simbolismo])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Simbolismo])
         (año_de_creacion  1946)
         (complejidad  "Media")
         (dimensiones  "0.30x0.22")
         (nombre  "El venado herido")
         (relevancia  "Media-alta")
    )

    ([Viva_la_vida] of ObraDeArte
         (tema  [Naturaleza])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Simbolismo])
         (año_de_creacion  1954)
         (complejidad  "Media")
         (dimensiones  "0.78x0.64")
         (nombre  "Viva la vida")
         (relevancia  "Media-alta")
    )

    ([Autorretrato_con_collar_de_espinas] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Simbolismo])
         (año_de_creacion  1940)
         (complejidad  "Alta")
         (dimensiones  "0.63x0.49")
         (nombre  "Autorretrato con collar de espinas")
         (relevancia  "Alta")
    )

    ([Henry_Ford_Hospital] of ObraDeArte
         (tema  [Simbolismo])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1932)
         (complejidad  "Alta")
         (dimensiones  "0.31x0.38")
         (nombre  "Henry Ford Hospital")
         (relevancia  "Alta")
    )

    ([Lo_Que_el_Agua_Me_Dio] of ObraDeArte
         (tema  [Simbolismo])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1938)
         (complejidad  "Alta")
         (dimensiones  "0.91x0.70")
         (nombre  "Lo Que el Agua Me Dio")
         (relevancia  "Media-alta")
    )

    ([El_Abrazo_de_Amor_de_El_Universo] of ObraDeArte
         (tema  [Simbolismo])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1949)
         (complejidad  "Alta")
         (dimensiones  "1.18x0.90")
         (nombre  "El Abrazo de Amor de El Universo")
         (relevancia  "Alta")
    )

    ([Mi_Vestido_Cuelga_Allí] of ObraDeArte
         (tema  [Simbolismo])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1933)
         (complejidad  "Media")
         (dimensiones  "0.39x0.47")
         (nombre  "Mi Vestido Cuelga Allí")
         (relevancia  "Media")
    )

    ([Unos_Cuantos_Piquetitos] of ObraDeArte
         (tema  [Simbolismo])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Surrealista])
         (año_de_creacion  1935)
         (complejidad  "Media")
         (dimensiones  "0.60x0.50")
         (nombre  "Unos Cuantos Piquetitos")
         (relevancia  "Media-alta")
    )

    ;;; Tema naturaleza
    ([Naturaleza] of Tematica
         (nombre  "Naturaleza")
    )

    ;;; Tema simbolismo
    ([Simbolismo] of Tematica
         (nombre  "Simbolismo")
    )

    ([Sala_Simbolismo] of Sala
         (contiene  [Las_dos_Fridas] [La_columna_rota] [El_venado_herido] [Viva_la_vida] [Autorretrato_con_collar_de_espinas] [Henry_Ford_Hospital] [Lo_Que_el_Agua_Me_Dio] [El_Abrazo_de_Amor_de_El_Universo] [Mi_Vestido_Cuelga_Allí] [Unos_Cuantos_Piquetitos])
         (nombre  "Sala Simbolismo")
    )

    ([Sala_Expresionismo] of Sala
         (contiene  [Convergencia] [Número_5_1948] [Ritmo_de_otoño] [Azul_Mural] [Eco] [Pasiphae] [La_Llama_Azul] [Lucifer] [One_Number_31_1950] [Lavanda_Mist] [Naranja_Rojo_Amarillo] [Blanco_y_Violeta] [Sin_Título_1953] [Rojos_1956] [Verde_y_Morado] [N_14] [Negro_Sobre_Rojo] [Azul_y_Gris] [Blanco_Sobre_Amarillo] [Multiforme] [Estudio_del_autorretrato] [Tres_estudios_para_figuras_al_pie_de_una_crucifixión] [Cabeza_I] [Figura_en_un_paisaje] [Pintura_1946] [Figura_tumbada] [Estudio_para_un_retrato_de_Van_Gogh] [Estudio_para_el_retrato_de_Papa_Inocencio_X] [Crucifixión_1965] [Tríptico_Mayo_1973])
         (nombre  "Sala Expresionismo")
    )

    ([Jackson_Pollock] of Pintor
         (autor_de  [Convergencia] [Número_5_1948] [Ritmo_de_otoño] [Azul_Mural] [Eco] [Pasiphae] [La_Llama_Azul] [Lucifer] [One_Number_31_1950] [Lavanda_Mist])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (nacionalidad  "Estadounidense")
         (nombre  "Jackson Pollock")
    )

    ([Convergencia] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (año_de_creacion  1952)
         (complejidad  "Alta")
         (dimensiones  "2.40x3.93")
         (nombre  "Convergencia")
         (relevancia  "Alta")
    )

    ([Número_5_1948] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (año_de_creacion  1948)
         (complejidad  "Alta")
         (dimensiones  "2.40x1.22")
         (nombre  "Número 5, 1948")
         (relevancia  "Alta")
    )

    ([Ritmo_de_otoño] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (año_de_creacion  1950)
         (complejidad  "Alta")
         (dimensiones  "2.66x5.25")
         (nombre  "Ritmo de otoño")
         (relevancia  "Alta")
    )

    ([Azul_Mural] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (año_de_creacion  1943)
         (complejidad  "Alta")
         (dimensiones  "2.43x6.08")
         (nombre  "Azul Mural")
         (relevancia  "Alta")
    )

    ([Eco] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (año_de_creacion  1951)
         (complejidad  "Media-alta")
         (dimensiones  "1.90x1.42")
         (nombre  "Eco")
         (relevancia  "Media-alta")
    )

    ([Pasiphae] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Expresionismo_Abstracto])
         (tiene_estilo  [Estilo_Drip_Painting])
         (año_de_creacion  1943)
         (complejidad  "Alta")
         (dimensiones  "1.29x2.40")
         (nombre  "Pasiphaë")
         (relevancia  "Alta")
    )

    ([La_Llama_Azul] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Expresionismo_Abstracto])
         (tiene_estilo  [Estilo_Drip_Painting])
         (año_de_creacion  1953)
         (complejidad  "Media")
         (dimensiones  "0.90x1.20")
         (nombre  "La Llama Azul")
         (relevancia  "Media")
    )

    ([Lucifer] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Expresionismo_Abstracto])
         (tiene_estilo  [Estilo_Drip_Painting])
         (año_de_creacion  1947)
         (complejidad  "Alta")
         (dimensiones  "1.44x2.24")
         (nombre  "Lucifer")
         (relevancia  "Alta")
    )

    ([One_Number_31_1950] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Expresionismo_Abstracto])
         (tiene_estilo  [Estilo_Drip_Painting])
         (año_de_creacion  1950)
         (complejidad  "Muy alta")
         (dimensiones  "2.69x5.30")
         (nombre  "One: Number 31, 1950")
         (relevancia  "Muy alta")
    )

    ([Lavanda_Mist] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Expresionismo_Abstracto])
         (tiene_estilo  [Estilo_Drip_Painting])
         (año_de_creacion  1950)
         (complejidad  "Alta")
         (dimensiones  "2.21x2.97")
         (nombre  "Lavanda Mist")
         (relevancia  "Alta")
    )

    ;;; Epoca del Expresionismo_Abstracto
    ([Epoca_Expresionismo_Abstracto] of Epoca
         (nombre  "Expresionismo_Abstracto")
    )

    ;;; Estilo Drip Painting
    ([Estilo_Drip_Painting] of Estilo
         (nombre  "Drip Painting")
    )

    ;;; Tema abstracto
    ([Abstracto] of Tematica
         (nombre  "Abstracto")
    )

    ([Mark_Rothko] of Pintor
         (autor_de  [Naranja_Rojo_Amarillo] [Blanco_y_Violeta] [Sin_Título_1953] [Rojos_1956] [Verde_y_Morado] [N_14] [Negro_Sobre_Rojo] [Azul_y_Gris] [Blanco_Sobre_Amarillo] [Multiforme])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (nacionalidad  "Estadounidense")
         (nombre  "Mark Rothko")
    )

    ([Naranja_Rojo_Amarillo] of ObraDeArte
         (tema  [Abstracto])
         (año_de_creacion  1961)
         (complejidad  "Alta")
         (dimensiones  "2.42x1.86")
         (nombre  "Naranja, Rojo, Amarillo")
         (relevancia  "Alta")
    )

    ([Blanco_y_Violeta] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (año_de_creacion  1957)
         (complejidad  "Media-alta")
         (dimensiones  "2.06x1.64")
         (nombre  "Blanco y Violeta")
         (relevancia  "Alta")
    )

    ([Sin_Título_1953] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (año_de_creacion  1953)
         (complejidad  "Alta")
         (dimensiones  "2.35x1.69")
         (nombre  "Sin Título, 1953")
         (relevancia  "Media-alta")
    )

    ([Rojos_1956] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (año_de_creacion  1956)
         (complejidad  "Media-alta")
         (dimensiones  "2.08x1.62")
         (nombre  "Rojos, 1956")
         (relevancia  "Alta")
    )

    ([Verde_y_Morado] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (año_de_creacion  1950)
         (complejidad  "Alta")
         (dimensiones  "1.70x1.30")
         (nombre  "Verde y Morado")
         (relevancia  "Alta")
    )

    ([N_14] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (año_de_creacion  1960)
         (complejidad  "Alta")
         (dimensiones  "2.88x2.12")
         (nombre  "Nº 14")
         (relevancia  "Alta")
    )

    ([Negro_Sobre_Rojo] of ObraDeArte
         (tema  [Abstracto])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (año_de_creacion  1958)
         (complejidad  "Alta")
         (dimensiones  "2.06x1.63")
         (nombre  "Negro Sobre Rojo")
         (relevancia  "Alta")
    )

    ([Azul_y_Gris] of ObraDeArte
         (tema  [Abstracto])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (año_de_creacion  1952)
         (complejidad  "Media-alta")
         (dimensiones  "1.85x1.27")
         (nombre  "Azul y Gris")
         (relevancia  "Media-alta")
    )

    ([Blanco_Sobre_Amarillo] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (año_de_creacion  1954)
         (complejidad  "Alta")
         (dimensiones  "1.80x1.35")
         (nombre  "Blanco Sobre Amarillo")
         (relevancia  "Alta")
    )

    ([Multiforme] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo_Abstracto])
         (año_de_creacion  1947)
         (complejidad  "Alta")
         (dimensiones  "1.68x1.25")
         (nombre  "Multiforme")
         (relevancia  "Alta")
    )

    ([Andy_Warhol] of Pintor
         (autor_de  [Latas_de_Sopa_Campbell] [Marilyn_Monroe] [Coca_Cola] [Banana] [Elvis] [Self_Portrait] [Double_Elvis] [Brillo_Box] [Car_Crash] [Mao])
         (tiene_epoca  [Epoca_Contemporaneo])
         (tiene_estilo  [Estilo_Pop_Art])
         (nacionalidad  "Estadounidense")
         (nombre  "Andy Warhol")
    )

    ([Latas_de_Sopa_Campbell] of ObraDeArte
         (tema  [Naturaleza])
         (tiene_epoca  [Epoca_Contemporaneo])
         (tiene_estilo  [Estilo_Pop_Art])
         (año_de_creacion  1962)
         (complejidad  "Media")
         (dimensiones  "0.51x0.41")
         (nombre  "Latas de Sopa Campbell")
         (relevancia  "Alta")
    )

    ([Marilyn_Monroe] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Contemporaneo])
         (tiene_estilo  [Estilo_Pop_Art])
         (año_de_creacion  1962)
         (complejidad  "Media")
         (dimensiones  "1.50x1.20")
         (nombre  "Marilyn Monroe")
         (relevancia  "Alta")
    )

    ([Coca_Cola] of ObraDeArte
         (tema  [Producto])
         (tiene_epoca  [Epoca_Contemporaneo])
         (tiene_estilo  [Estilo_Pop_Art])
         (año_de_creacion  1962)
         (complejidad  "Media")
         (dimensiones  "1.37x0.81")
         (nombre  "Coca Cola")
         (relevancia  "Media-alta")
    )

    ([Banana] of ObraDeArte
         (tema  [Producto])
         (tiene_epoca  [Epoca_Contemporaneo])
         (tiene_estilo  [Estilo_Pop_Art])
         (año_de_creacion  1967)
         (complejidad  "Media")
         (dimensiones  "0.61x0.30")
         (nombre  "Banana")
         (relevancia  "Media")
    )

    ([Elvis] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Contemporaneo])
         (tiene_estilo  [Estilo_Pop_Art])
         (año_de_creacion  1963)
         (complejidad  "Media")
         (dimensiones  "2.08x1.22")
         (nombre  "Elvis")
         (relevancia  "Alta")
    )

    ([Self_Portrait] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Contemporaneo])
         (tiene_estilo  [Estilo_Pop_Art])
         (año_de_creacion  1986)
         (complejidad  "Media-alta")
         (dimensiones  "2.08x1.22")
         (nombre  "Self Portrait")
         (relevancia  "Alta")
    )

    ([Double_Elvis] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Contemporaneo])
         (tiene_estilo  [Estilo_Pop_Art])
         (año_de_creacion  1963)
         (complejidad  "Alta")
         (dimensiones  "2.08x2.44")
         (nombre  "Double Elvis")
         (relevancia  "Alta")
    )

    ([Brillo_Box] of ObraDeArte
         (tema  [Producto])
         (tiene_epoca  [Epoca_Contemporaneo])
         (tiene_estilo  [Estilo_Pop_Art])
         (año_de_creacion  1964)
         (complejidad  "Media")
         (dimensiones  "0.43x0.43x0.43")
         (nombre  "Brillo Box")
         (relevancia  "Media-alta")
    )

    ([Car_Crash] of ObraDeArte
         (tema  [Catástrofe])
         (tiene_epoca  [Epoca_Contemporaneo])
         (tiene_estilo  [Estilo_Pop_Art])
         (año_de_creacion  1963)
         (complejidad  "Alta")
         (dimensiones  "1.73x2.13")
         (nombre  "Car Crash")
         (relevancia  "Alta")
    )

    ([Mao] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Contemporaneo])
         (tiene_estilo  [Estilo_Pop_Art])
         (año_de_creacion  1972)
         (complejidad  "Media-alta")
         (dimensiones  "2.08x1.58")
         (nombre  "Mao")
         (relevancia  "Alta")
    )

    ;;; Epoca Contemporanea
    ([Epoca_Contemporaneo] of Epoca
         (nombre  "Contemporaneo")
    )

    ;;; Estilo Pop Art
    ([Estilo_Pop_Art] of Estilo
         (nombre  "Pop Art")
    )

    ;;; Tema catástrofe
    ([Catástrofe] of Tematica
         (nombre  "Catástrofe")
    )

    ;;; Tema producto
    ([Producto] of Tematica
         (nombre  "Producto")
    )

    ([Sala_Warhol] of Sala
         (contiene  [Latas_de_Sopa_Campbell] [Marilyn_Monroe] [Coca_Cola] [Banana] [Elvis] [Self_Portrait] [Double_Elvis] [Brillo_Box] [Car_Crash] [Mao])
         (nombre  "Sala Warhol")
    )

    ([Sala_O_Keefe] of Sala
         (contiene  [Flor_Blanca] [Cañón_de_Pedernal] [Lirio_Negro] [Cráneo_de_Vaca_con_Rosa] [El_Cañón_Abanico] [Nubes_Caladas] [Cuernos_y_Red] [Rosa_de_Abanico] [Calle_Nueva_York_N1] [Mano_de_Buda])
         (nombre  "Sala O_Keefe")
    )

    ([Georgia_O_Keefe] of Pintor
         (autor_de  [Flor_Blanca] [Cañón_de_Pedernal] [Lirio_Negro] [Cráneo_de_Vaca_con_Rosa] [El_Cañón_Abanico] [Nubes_Caladas] [Cuernos_y_Red] [Rosa_de_Abanico] [Calle_Nueva_York_N1] [Mano_de_Buda])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Abstracto_y_Naturalismo])
         (nacionalidad  "Estadounidense")
         (nombre  "Georgia O'Keeffe")
    )

    ;;; Estilo Abstracto y Naturalismo
    ([Estilo_Abstracto_y_Naturalismo] of Estilo
         (nombre  "Abstracto y Naturalismo")
    )

    ([Flor_Blanca] of ObraDeArte
         (tema  [Naturaleza])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Abstraccionismo])
         (año_de_creacion  1932)
         (complejidad  "Media")
         (dimensiones  "0.71x0.56")
         (nombre  "Flor Blanca")
         (relevancia  "Media-alta")
    )

    ([Cañón_de_Pedernal] of ObraDeArte
         (tema  [Paisaje])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Realismo])
         (año_de_creacion  1941)
         (complejidad  "Alta")
         (dimensiones  "1.00x0.80")
         (nombre  "Cañón de Pedernal")
         (relevancia  "Alta")
    )

    ([Lirio_Negro] of ObraDeArte
         (tema  [Naturaleza])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Abstraccionismo])
         (año_de_creacion  1926)
         (complejidad  "Media")
         (dimensiones  "0.90x0.60")
         (nombre  "Lirio Negro")
         (relevancia  "Media")
    )

    ([Cráneo_de_Vaca_con_Rosa] of ObraDeArte
         (tema  [Naturaleza])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Simbolismo])
         (año_de_creacion  1931)
         (complejidad  "Alta")
         (dimensiones  "0.85x0.65")
         (nombre  "Cráneo de Vaca con Rosa")
         (relevancia  "Alta")
    )

    ([El_Cañón_Abanico] of ObraDeArte
         (tema  [Paisaje])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Realismo])
         (año_de_creacion  1949)
         (complejidad  "Media-alta")
         (dimensiones  "1.10x0.90")
         (nombre  "El Cañón Abanico")
         (relevancia  "Media-alta")
    )

    ([Nubes_Caladas] of ObraDeArte
         (tema  [Paisaje])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Abstraccionismo])
         (año_de_creacion  1950)
         (complejidad  "Media")
         (dimensiones  "1.20x0.90")
         (nombre  "Nubes Caladas")
         (relevancia  "Media")
    )

    ([Cuernos_y_Red] of ObraDeArte
         (tema  [Naturaleza])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Simbolismo])
         (año_de_creacion  1934)
         (complejidad  "Media-alta")
         (dimensiones  "0.80x0.60")
         (nombre  "Cuernos y Red")
         (relevancia  "Media-alta")
    )

    ([Rosa_de_Abanico] of ObraDeArte
         (tema  [Naturaleza])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Abstraccionismo])
         (año_de_creacion  1947)
         (complejidad  "Media")
         (dimensiones  "0.75x0.60")
         (nombre  "Rosa de Abanico")
         (relevancia  "Media")
    )

    ([Calle_Nueva_York_N1] of ObraDeArte
         (tema  [Urbanismo])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Realismo])
         (año_de_creacion  1925)
         (complejidad  "Alta")
         (dimensiones  "1.20x0.90")
         (nombre  "Calle Nueva York N1")
         (relevancia  "Alta")
    )

    ([Mano_de_Buda] of ObraDeArte
         (tema  [Simbolismo])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Simbolismo])
         (año_de_creacion  1953)
         (complejidad  "Media")
         (dimensiones  "0.90x0.70")
         (nombre  "Mano de Buda")
         (relevancia  "Media-alta")
    )

    ;;; Tema urbanismo
    ([Urbanismo] of Tematica
         (nombre  "Urbanismo")
    )

    ;;; Estilo Realismo
    ([Estilo_Realismo] of Estilo
         (nombre  "Realismo")
    )

    ;;; Estilo Abstraccionismo
    ([Estilo_Abstraccionismo] of Estilo
         (nombre  "Abstraccionismo")
    )

    ([Francis_Bacon] of Pintor
         (autor_de  [Estudio_del_autorretrato] [Tres_estudios_para_figuras_al_pie_de_una_crucifixión] [Cabeza_I] [Figura_en_un_paisaje] [Pintura_1946] [Figura_tumbada] [Estudio_para_un_retrato_de_Van_Gogh] [Estudio_para_el_retrato_de_Papa_Inocencio_X] [Crucifixión_1965] [Tríptico_Mayo_1973])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo])
         (nacionalidad  "Británico")
         (nombre  "Francis Bacon")
    )

    ([Estudio_del_autorretrato] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo])
         (año_de_creacion  1971)
         (complejidad  "Alta")
         (dimensiones  "0.81x0.71")
         (nombre  "Estudio del autorretrato")
         (relevancia  "Alta")
    )

    ([Tres_estudios_para_figuras_al_pie_de_una_crucifixión] of ObraDeArte
         (tema  [Crucifixión])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo])
         (año_de_creacion  1944)
         (complejidad  "Alta")
         (dimensiones  "1.75x2.13")
         (nombre  "Tres estudios para figuras al pie de una crucifixión")
         (relevancia  "Alta")
    )

    ([Cabeza_I] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo])
         (año_de_creacion  1949)
         (complejidad  "Alta")
         (dimensiones  "0.51x0.43")
         (nombre  "Cabeza I")
         (relevancia  "Alta")
    )

    ([Figura_en_un_paisaje] of ObraDeArte
         (tema  [Figura])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo])
         (año_de_creacion  1945)
         (complejidad  "Alta")
         (dimensiones  "1.20x1.53")
         (nombre  "Figura en un paisaje")
         (relevancia  "Alta")
    )

    ([Pintura_1946] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo])
         (año_de_creacion  1946)
         (complejidad  "Alta")
         (dimensiones  "1.27x1.52")
         (nombre  "Pintura 1946")
         (relevancia  "Alta")
    )

    ([Figura_tumbada] of ObraDeArte
         (tema  [Figura])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo])
         (año_de_creacion  1969)
         (complejidad  "Alta")
         (dimensiones  "1.55x1.95")
         (nombre  "Figura tumbada")
         (relevancia  "Alta")
    )

    ([Estudio_para_un_retrato_de_Van_Gogh] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo])
         (año_de_creacion  1957)
         (complejidad  "Alta")
         (dimensiones  "0.76x0.66")
         (nombre  "Estudio para un retrato de Van Gogh")
         (relevancia  "Alta")
    )

    ([Estudio_para_el_retrato_de_Papa_Inocencio_X] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo])
         (año_de_creacion  1953)
         (complejidad  "Alta")
         (dimensiones  "1.43x1.22")
         (nombre  "Estudio para el retrato de Papa Inocencio X")
         (relevancia  "Alta")
    )

    ([Crucifixión_1965] of ObraDeArte
         (tema  [Crucifixión])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo])
         (año_de_creacion  1965)
         (complejidad  "Alta")
         (dimensiones  "1.70x2.00")
         (nombre  "Crucifixión 1965")
         (relevancia  "Alta")
    )

    ([Tríptico_Mayo_1973] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Expresionismo])
         (año_de_creacion  1973)
         (complejidad  "Alta")
         (dimensiones  "1.85x3.10")
         (nombre  "Tríptico Mayo 1973")
         (relevancia  "Alta")
    )

    ;;; Estilo Expresionismo
    ([Estilo_Expresionismo] of Estilo
         (nombre  "Expresionismo")
    )

    ;;; Tema crucifixión
    ([Crucifixión] of Tematica
         (nombre  "Crucifixión")
    )

    ;;; Tema figura
    ([Figura] of Tematica
         (nombre  "Figura")
    )

    ([Jean_Michel_Basquiat] of Pintor
         (autor_de  [Sin_título_1981] [Hollywood_Africans] [Flexible] [Horn_Players] [Boy_and_Dog_in_a_Johnnypump] [Untitled_Boxer] [Crown] [Dustheads] [Profit_I] [Riding_with_Death])
         (tiene_epoca  [Epoca_Contemporaneo])
         (tiene_estilo  [Estilo_Expresionismo])
         (nacionalidad  "Estadounidense")
         (nombre  "Jean-Michel Basquiat")
    )

    ([Sin_título_1981] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Arte_Urbano])
         (año_de_creacion  1981)
         (complejidad  "Alta")
         (dimensiones  "1.83x1.40")
         (nombre  "Sin título 1981")
         (relevancia  "Alta")
    )

    ([Hollywood_Africans] of ObraDeArte
         (tema  [Cultura_Afrolatina])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Arte_Urbano])
         (año_de_creacion  1983)
         (complejidad  "Alta")
         (dimensiones  "1.50x1.20")
         (nombre  "Hollywood Africans")
         (relevancia  "Alta")
    )

    ([Flexible] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Arte_Urbano])
         (año_de_creacion  1984)
         (complejidad  "Alta")
         (dimensiones  "2.10x1.60")
         (nombre  "Flexible")
         (relevancia  "Alta")
    )

    ([Horn_Players] of ObraDeArte
         (tema  [Música])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Arte_Urbano])
         (año_de_creacion  1983)
         (complejidad  "Alta")
         (dimensiones  "1.50x1.80")
         (nombre  "Horn Players")
         (relevancia  "Alta")
    )

    ([Boy_and_Dog_in_a_Johnnypump] of ObraDeArte
         (tema  [Familia])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Arte_Urbano])
         (año_de_creacion  1982)
         (complejidad  "Alta")
         (dimensiones  "1.60x1.80")
         (nombre  "Boy and Dog in a Johnnypump")
         (relevancia  "Alta")
    )

    ([Untitled_Boxer] of ObraDeArte
         (tema  [Deporte])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Arte_Urbano])
         (año_de_creacion  1982)
         (complejidad  "Alta")
         (dimensiones  "1.90x1.50")
         (nombre  "Untitled Boxer")
         (relevancia  "Alta")
    )

    ([Crown] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Arte_Urbano])
         (año_de_creacion  1981)
         (complejidad  "Alta")
         (dimensiones  "1.20x1.50")
         (nombre  "Crown")
         (relevancia  "Alta")
    )

    ([Dustheads] of ObraDeArte
         (tema  [Retrato])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Arte_Urbano])
         (año_de_creacion  1982)
         (complejidad  "Alta")
         (dimensiones  "1.60x1.20")
         (nombre  "Dustheads")
         (relevancia  "Alta")
    )

    ([Profit_I] of ObraDeArte
         (tema  [Abstracto])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Arte_Urbano])
         (año_de_creacion  1983)
         (complejidad  "Alta")
         (dimensiones  "2.00x1.50")
         (nombre  "Profit I")
         (relevancia  "Alta")
    )

    ([Riding_with_Death] of ObraDeArte
         (tema  [Muerte])
         (tiene_epoca  [Epoca_Modernismo])
         (tiene_estilo  [Estilo_Arte_Urbano])
         (año_de_creacion  1988)
         (complejidad  "Alta")
         (dimensiones  "1.50x1.70")
         (nombre  "Riding with Death")
         (relevancia  "Alta")
    )

    ;;; Estilo Arte Urbano
    ([Estilo_Arte_Urbano] of Estilo
         (nombre  "Arte Urbano")
    )

    ;;; Tema cultura afrolatina
    ([Cultura_Afrolatina] of Tematica
         (nombre  "Cultura Afrolatina")
    )

    ;;; Tema deporte
    ([Deporte] of Tematica
         (nombre  "Deporte")
    )

    ;;; Tema muerte
    ([Muerte] of Tematica
         (nombre  "Muerte")
    )

    ([Sala_Arte_Urbano] of Sala
         (contiene  [Sin_título_1981] [Hollywood_Africans] [Flexible] [Horn_Players] [Boy_and_Dog_in_a_Johnnypump] [Untitled_Boxer] [Crown] [Dustheads] [Profit_I] [Riding_with_Death])
         (nombre  "Sala Arte Urbano")
    )

)
