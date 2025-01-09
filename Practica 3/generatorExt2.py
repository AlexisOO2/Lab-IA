import random
import time

contenido = [
    {"titulo": "Iron_Man", "universo": "Marvel", "emision": 2008, "universo_temporal": 2010, "tipo": "pelicula"},
    {"titulo": "Thor", "universo": "Marvel", "emision": 2011, "universo_temporal": 2011, "tipo": "pelicula"},
    {"titulo": "Los_Vengadores", "universo": "Marvel", "emision": 2012, "universo_temporal": 2012, "tipo": "pelicula"},
    {"titulo": "Capitán_América_El_Primer_Vengador", "universo": "Marvel", "emision": 2011, "universo_temporal": 1942, "tipo": "pelicula"},
    {"titulo": "Thor_Un_Mundo_Oscuro", "universo": "Marvel", "emision": 2013, "universo_temporal": 2013, "tipo": "pelicula"},
    {"titulo": "Capitán_América_El_Soldado_de_Invierno", "universo": "Marvel", "emision": 2014, "universo_temporal": 2014, "tipo": "pelicula"},
    {"titulo": "Los_Vengadores_La_Era_de_Ultrón", "universo": "Marvel", "emision": 2015, "universo_temporal": 2015, "tipo": "pelicula"},
    {"titulo": "Doctor_Strange", "universo": "Marvel", "emision": 2016, "universo_temporal": 2016, "tipo": "pelicula"},
    {"titulo": "Spider-Man_Homecoming", "universo": "Marvel", "emision": 2017, "universo_temporal": 2016, "tipo": "pelicula"},
    {"titulo": "Avengers_Infinity_War", "universo": "Marvel", "emision": 2018, "universo_temporal": 2018, "tipo": "pelicula"},
    {"titulo": "Avengers_Endgame", "universo": "Marvel", "emision": 2019, "universo_temporal": 2023, "tipo": "pelicula"},

    {"titulo": "Superman_El_Hombre_de_Acero", "universo": "DC", "emision": 2013, "universo_temporal": 2013, "tipo": "pelicula"},
    {"titulo": "Batman_v_Superman_El_Amanecer_de_la_Justicia", "universo": "DC", "emision": 2016, "universo_temporal": 2016, "tipo": "pelicula"},
    {"titulo": "Escuadrón_Suicida", "universo": "DC", "emision": 2016, "universo_temporal": 2016, "tipo": "pelicula"},
    {"titulo": "Liga_de_la_Justicia", "universo": "DC", "emision": 2017, "universo_temporal": 2017, "tipo": "pelicula"},
    {"titulo": "Aquaman", "universo": "DC", "emision": 2018, "universo_temporal": 2018, "tipo": "pelicula"},
    {"titulo": "Shazam", "universo": "DC", "emision": 2019, "universo_temporal": 2019, "tipo": "pelicula"},

    {"titulo": "Star_Trek_La_Serie_Original_T1_C1", "universo": "Star_Trek", "emision": 1966, "universo_temporal": 2265, "tipo": "serie", "temporada": 1, "capitulo": 1},
    {"titulo": "Star_Trek_La_Serie_Original_T1_C2", "universo": "Star_Trek", "emision": 1966, "universo_temporal": 2265, "tipo": "serie", "temporada": 1, "capitulo": 2},
    {"titulo": "Star_Trek_La_Serie_Original_T2_C1", "universo": "Star_Trek", "emision": 1967, "universo_temporal": 2266, "tipo": "serie", "temporada": 2, "capitulo": 1},
    {"titulo": "Star_Trek_La_Serie_Original_T2_C2", "universo": "Star_Trek", "emision": 1967, "universo_temporal": 2266, "tipo": "serie", "temporada": 2, "capitulo": 2},
    {"titulo": "Star_Trek_II_La_Ira_de_Khan", "universo": "Star_Trek", "emision": 1982, "universo_temporal": 2285, "tipo": "pelicula"},
    {"titulo": "Star_Trek_III_En_Busca_de_Spock", "universo": "Star_Trek", "emision": 1984, "universo_temporal": 2285, "tipo": "pelicula"},
    {"titulo": "Star_Trek_IV_Misión_Salvar_la_Tierra", "universo": "Star_Trek", "emision": 1986, "universo_temporal": 2286, "tipo": "pelicula"},
    {"titulo": "Star_Trek_La_Película", "universo": "Star_Trek", "emision": 1979, "universo_temporal": 2273, "tipo": "pelicula"},

    {"titulo": "Stargate_La_Película", "universo": "Stargate", "emision": 1994, "universo_temporal": 1994, "tipo": "pelicula"},
    {"titulo": "Stargate_SG-1_T1_C1", "universo": "Stargate", "emision": 1997, "universo_temporal": 1997, "tipo": "serie", "temporada": 1, "capitulo": 1},
    {"titulo": "Stargate_SG-1_T1_C2", "universo": "Stargate", "emision": 1997, "universo_temporal": 1997, "tipo": "serie", "temporada": 1, "capitulo": 2},
    {"titulo": "Stargate_SG-1_T2_C1", "universo": "Stargate", "emision": 1998, "universo_temporal": 1998, "tipo": "serie", "temporada": 2, "capitulo": 1},
    {"titulo": "Stargate_Atlantis_T1_C1", "universo": "Stargate", "emision": 2004, "universo_temporal": 2004, "tipo": "serie", "temporada": 1, "capitulo": 1},

    {"titulo": "Doctor_Who_T1_C1", "universo": "Doctor_Who", "emision": 2005, "universo_temporal": 2005, "tipo": "serie", "temporada": 1, "capitulo": 1},
    {"titulo": "Doctor_Who_T1_C2", "universo": "Doctor_Who", "emision": 2005, "universo_temporal": 2005, "tipo": "serie", "temporada": 1, "capitulo": 2},
    {"titulo": "Torchwood_T1_C1", "universo": "Doctor_Who", "emision": 2006, "universo_temporal": 2006, "tipo": "serie", "temporada": 1, "capitulo": 1},
    {"titulo": "Torchwood_T1_C2", "universo": "Doctor_Who", "emision": 2006, "universo_temporal": 2006, "tipo": "serie", "temporada": 1, "capitulo": 2}
]

dias = [f"Dia{i}" for i in range(1, 31)]

# Función para generar un problema aleatorio
def generar_problema(seed_val, num_peliculas, num_dias):
    random.seed(seed_val)
    
    # Elegir un número aleatorio de películas o series
    peliculas_seleccionadas = random.sample(contenido, num_peliculas)
    
    # Generar las relaciones de predecesores
    predecesores = []
    for i in range(len(peliculas_seleccionadas) - 1):
        if peliculas_seleccionadas[i]["universo"] == peliculas_seleccionadas[i+1]["universo"]:
            if peliculas_seleccionadas[i]["emision"] < peliculas_seleccionadas[i+1]["emision"]:
                predecesores.append((peliculas_seleccionadas[i]["titulo"], peliculas_seleccionadas[i+1]["titulo"]))
            else:
                predecesores.append((peliculas_seleccionadas[i+1]["titulo"], peliculas_seleccionadas[i]["titulo"]))
    
    # Generar relaciones de predecesores entre capítulos de series
    for serie in [item for item in peliculas_seleccionadas if item["tipo"] == "serie"]:
        nombre_serie = serie["titulo"]
        # ajustar
        for i in range(1, serie["temporada"] + 1):
            predecesores.append((f"{nombre_serie}", f"{nombre_serie}"))
    
    # Generar relaciones de paralelismo temporal
    paralelos = []
    for i in range(len(peliculas_seleccionadas)):
        for j in range(i + 1, len(peliculas_seleccionadas)):
            if peliculas_seleccionadas[i]["universo_temporal"] == peliculas_seleccionadas[j]["universo_temporal"]:
                paralelos.append((peliculas_seleccionadas[i]["titulo"], peliculas_seleccionadas[j]["titulo"]))
                paralelos.append((peliculas_seleccionadas[j]["titulo"], peliculas_seleccionadas[i]["titulo"]))
    
    # Generar el archivo PDDL
    with open("genProblemExt2.pddl", "w", encoding="utf-8") as f:
        f.write("(define (problem p1) (:domain redflix)\n")
        
        f.write("(:objects \n")
        for pelicula in peliculas_seleccionadas:
            f.write(f"{pelicula['titulo']} ")
        f.write("- contenido\n")
        for dia in dias[:num_dias]:
            f.write(f"{dia} ")
        f.write(f"- dia\n")
        f.write(")\n")
        
        f.write("(:init\n")
        for i in range(1, num_dias):
            f.write(f"  (diaAnterior Dia{i} Dia{i+1})\n")
        f.write("\n")
        
        for pelicula in peliculas_seleccionadas:
            f.write(f"  (contenidoDisponible {pelicula['titulo']})\n")
        f.write("\n")
        
        for p1, p2 in predecesores:
            f.write(f"  (predecesor {p1} {p2})\n")
        
        for p1, p2 in paralelos:
            f.write(f"  (paralelo {p1} {p2})\n")
        
        f.write("\n")
        
        pelicula_objetivo = random.choice(peliculas_seleccionadas)
        dia_objetivo = random.choice(dias[:num_dias])
        
        f.write(")\n")
        f.write(f"(:goal (and (contenidoVisto {pelicula_objetivo['titulo']}) (enDia {pelicula_objetivo['titulo']} {dia_objetivo})))\n")
        f.write(")\n")

if __name__ == "__main__":
    # Parámetros: semilla, número de películas y número de días
    seed_value = int(time.time() * 1000)
    generar_problema(seed_value, 10, 20)
