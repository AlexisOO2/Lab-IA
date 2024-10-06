import IA.Azamon.Paquete;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class AzamonInitialSolution {

    private ArrayList<Paquete> capacityFirstSolution(ArrayList<Paquete> packages) {
        packages.sort(Comparator.comparingDouble(Paquete::getPeso));
        return packages;
    }

    private ArrayList<Paquete> priorityFirstSolution(ArrayList<Paquete> packages) {
        packages.sort(Comparator.comparingInt(Paquete::getPrioridad));
        return packages;
    }

    private ArrayList<Paquete> randomSolution(ArrayList<Paquete> packages) {
        Collections.shuffle(packages);
        return packages;
    }
}