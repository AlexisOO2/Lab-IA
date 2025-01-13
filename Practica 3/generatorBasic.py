import random

# Lista de sagas (cada saga es una lista de películas)
sagas = [
    ["Capitan_America_El_Primer_Vengador", "Capitan_America_El_Soldado_de_Invierno", "Capitan_America_Civil_War"],
    ["Iron_Man", "Iron_Man_2", "Iron_Man_3"],
    ["Thor", "Thor_El_Mundo_Oscuro", "Thor_Ragnarok"],
    ["Guardianes_de_la_Galaxia", "Guardianes_de_la_Galaxia_Vol_2"],
    ["Los_Vengadores", "Los_Vengadores_La_Era_de_Ultron", "Los_Vengadores_Infinity_War", "Los_Vengadores_Endgame"],
    ["Capitana_Marvel"],
    ["Black_Panther"],
    ["Doctor_Strange"],
    ["Ant-Man", "Ant-Man_and_the_Wasp"],
    ["Spiderman_Homecoming", "Spiderman_Far_From_Home", "Spiderman_No_Way_Home"],
    ["Shang_Chi_y_la_Legenda_de_los_Diez_Anillos"],
    ["Eternals"],
    ["SpiderMan_Into_the_Spiderverse", "SpiderMan_Across_the_Spiderverse"],
    ["Thor_Love_and_Thunder"],
    ["Black_Panther_Wakanda_Forever"],
    ["Doctor_Strange_en_el_Multiverso_de_la_Locura"]
]

# Orden cronológico de las películas (este orden no cambia)
orden_cronologico = [
    "Capitan_America_El_Primer_Vengador", "Capitan_America_El_Soldado_de_Invierno", "Capitan_America_Civil_War",
    "Iron_Man", "Iron_Man_2", "Iron_Man_3",
    "Thor", "Thor_El_Mundo_Oscuro", "Thor_Ragnarok",
    "Guardianes_de_la_Galaxia", "Guardianes_de_la_Galaxia_Vol_2",
    "Los_Vengadores", "Los_Vengadores_La_Era_de_Ultron", "Los_Vengadores_Infinity_War", "Los_Vengadores_Endgame",
    "Capitana_Marvel", "Black_Panther", "Doctor_Strange","Ant-Man","Ant-Man_and_the_Wasp",
    "Spiderman_Homecoming","Spiderman_Far_From_Home","Spiderman_No_Way_Home",
    "Shang_Chi_y_la_Legenda_de_los_Diez_Anillos",
    "Eternals",
    "SpiderMan_Into_the_Spiderverse", "SpiderMan_Across_the_Spiderverse",
    "Thor_Love_and_Thunder",
    "Black_Panther_Wakanda_Forever",
    "Doctor_Strange_en_el_Multiverso_de_la_Locura"
]

# Días disponibles
dias = [f"Dia{i}" for i in range(1, 21)]

# Función para generar un problema aleatorio
def generar_problema(seed_val, num_peliculas, num_dias):
    random.seed(seed_val)
    
    todas_las_peliculas = []
    for saga in sagas:
        todas_las_peliculas.extend(saga)
    
    # Elegir un número aleatorio de películas
    peliculas_seleccionadas = random.sample(todas_las_peliculas, num_peliculas)
    
    # Generar las relaciones de predecesores por saga
    predecesores = []
    for saga in sagas:
        peliculas_saga = [p for p in saga if p in peliculas_seleccionadas]
        
        for i in range(len(peliculas_saga) - 1):
            predecesores.append((peliculas_saga[i], peliculas_saga[i+1]))  # Película i es predecesora de i+1
    
    # Generar relaciones de predecesores por cronologia
    peliculas_ordenadas = [p for p in orden_cronologico if p in peliculas_seleccionadas]
    
    for i in range(len(peliculas_ordenadas) - 1):
        predecesores.append((peliculas_ordenadas[i], peliculas_ordenadas[i+1]))  # Película i es predecesora de i+1
    
    # Generar el archivo PDDL
    with open("genProblemBasic.pddl", "w", encoding="utf-8") as f:
        f.write("(define (problem p1) (:domain redflix_basic)\n")
        
        f.write("(:objects \n")
        for pelicula in peliculas_seleccionadas:
            f.write(f"{pelicula} ")
        f.write("- contenido\n")
        for dia in dias[:num_dias]:
            f.write(f"{dia} ")
        f.write(f"- dia\n")
        f.write(")\n")
        
        f.write("(:init\n")
        
        for pelicula in peliculas_seleccionadas:
            f.write(f"  (contenidoDisponible {pelicula})\n")
        f.write("\n")
        
        for p1, p2 in predecesores:
            f.write(f"  (predecesor {p1} {p2})\n")
        f.write("\n")
        
        pelicula_objetivo = random.choice(peliculas_seleccionadas)
        dia_objetivo = random.choice(dias[:num_dias])
        
        f.write(")\n")
        f.write(f"(:goal (and (contenidoVisto {pelicula_objetivo})))\n")
        f.write(")\n")

if __name__ == "__main__":
    # Parámetros: semilla, número de películas y número de días
    generar_problema(21, 10, 20)