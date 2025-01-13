import random
import time

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
    
    # Generar el número de días: mayor que num_peliculas/3 y menor o igual a num_peliculas
    min_dias = (num_peliculas // 2) + 1
    max_dias = num_peliculas + (num_peliculas // 2)
    dias_seleccionados = random.randint(min_dias, max_dias)
    
    # Generar las relaciones de predecesores por saga
    predecesores = []
    for saga in sagas:
        peliculas_saga = [p for p in saga if p in peliculas_seleccionadas]
        
        for i in range(len(peliculas_saga) - 1):
            predecesores.append((peliculas_saga[i], peliculas_saga[i+1]))  # Película i es predecesora de i+1
    
    # Generar relaciones de predecesores por cronología
    peliculas_ordenadas = [p for p in orden_cronologico if p in peliculas_seleccionadas]
    
    for i in range(len(peliculas_ordenadas) - 1):
        predecesores.append((peliculas_ordenadas[i], peliculas_ordenadas[i+1]))  # Película i es predecesora de i+1
    
    # Generar paralelismos aleatorios con un 10% de probabilidad
    paralelos = []
    for i in range(len(peliculas_seleccionadas)):
        for j in range(i + 1, len(peliculas_seleccionadas)):
            if random.random() < 0.10:  #probabilidad
                paralelos.append((peliculas_seleccionadas[i], peliculas_seleccionadas[j]))
    
    # Generar el archivo PDDL
    with open("genProblemExt4.pddl", "w", encoding="utf-8") as f:
        f.write("(define (problem p1) (:domain redflix_ext4)\n")
        
        f.write("(:objects \n")
        for pelicula in peliculas_seleccionadas:
            f.write(f"{pelicula} ")
        f.write("- contenido\n")
        for dia in dias[:dias_seleccionados]:  # Usar el número de días seleccionado
            f.write(f"{dia} ")
        f.write(f"- dia\n")
        f.write(")\n")
        
        f.write("(:init\n")
        for i in range(1, dias_seleccionados):  # Generar la relación de días anteriores hasta el número de días seleccionado
            f.write(f"  (diaAnterior Dia{i} Dia{i+1})\n")
        
        f.write(")\n")
        # Asignación de duraciones aleatorias para cada película
        for pelicula in peliculas_seleccionadas:
            duracion = random.randint(60, 120)  # Duración aleatoria entre 60 y 120 minutos
            f.write(f"  (= (duracion {pelicula}) {duracion})\n")
        
        f.write(")\n")
        for pelicula in peliculas_seleccionadas:
            f.write(f"  (contenidoDisponible {pelicula})\n")
        
        f.write(")\n")
        for p1, p2 in predecesores:
            f.write(f"  (predecesor {p1} {p2})\n")
        
        f.write(")\n")
        for p1, p2 in paralelos:
            f.write(f"  (paralelo {p1} {p2})\n")
        
        # Generar el goal con entre 1 y 3 películas aleatorias
        num_objetivos = random.randint(1, 3)  # Elegir entre 1, 2 o 3 películas
        peliculas_objetivo = random.sample(peliculas_seleccionadas, num_objetivos)
        
        f.write(")\n")
        f.write(f"(:goal (and ")
        for pelicula in peliculas_objetivo:
            f.write(f"(contenidoVisto {pelicula}) ")
        f.write("))\n")
        f.write(")\n")

if __name__ == "__main__":
    # Parámetros: semilla, número de películas y número de días
    seed_value = int(time.time() * 1000)
    generar_problema(seed_value, 10, 20)
