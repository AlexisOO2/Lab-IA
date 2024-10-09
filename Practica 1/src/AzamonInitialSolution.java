import IA.Azamon.Oferta;
import IA.Azamon.Paquete;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;

public class AzamonInitialSolution {

    public HashMap<Oferta, Paquete> capacityFirstSolution(HashMap<Oferta, Paquete> offers, ArrayList<Paquete> packages) {
        packages.sort(Comparator.comparingDouble(Paquete::getPeso));
        return fillCapacity(offers, packages);
    }

    public HashMap<Oferta, Paquete> priorityFirstSolution(HashMap<Oferta, Paquete> offers, ArrayList<Paquete> packages) {
        packages.sort(Comparator.comparingInt(Paquete::getPrioridad));
        return fillCapacity(offers, packages);
    }

    public HashMap<Oferta, Paquete> randomSolution(HashMap<Oferta, Paquete> offers, ArrayList<Paquete> packages) {
        Collections.shuffle(packages);
        return fillCapacity(offers, packages);
    }

    private HashMap<Oferta, Paquete> fillCapacity(HashMap<Oferta, Paquete> offers, ArrayList<Paquete> packages){
        for(Oferta o : offers.keySet()) {
            double maxWeight = o.getPesomax();
            double currentWeight = 0;
            for(Paquete p : packages) {
                if(currentWeight + p.getPeso() <= maxWeight) {
                    offers.put(o,p);
                    currentWeight += p.getPeso();
                    packages.remove(p);
                }
            }
        }

        return offers;
    }
}