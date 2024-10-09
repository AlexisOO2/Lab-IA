import IA.Azamon.Oferta;
import IA.Azamon.Paquete;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;

public class AzamonInitialSolution {

    public HashMap<Oferta, ArrayList<Paquete>> capacityFirstSolution(HashMap<Oferta, ArrayList<Paquete>> offers, ArrayList<Paquete> packages) {
        packages.sort(Comparator.comparingDouble(Paquete::getPeso));
        return fillCapacity(offers, packages);
    }

    public HashMap<Oferta, ArrayList<Paquete>> priorityFirstSolution(HashMap<Oferta, ArrayList<Paquete>> offers, ArrayList<Paquete> packages) {
        packages.sort(Comparator.comparingInt(Paquete::getPrioridad));
        return fillCapacity(offers, packages);
    }

    public HashMap<Oferta, ArrayList<Paquete>> randomSolution(HashMap<Oferta, ArrayList<Paquete>> offers, ArrayList<Paquete> packages) {
        Collections.shuffle(packages);
        return fillCapacity(offers, packages);
    }

    private HashMap<Oferta, ArrayList<Paquete>> fillCapacity(HashMap<Oferta, ArrayList<Paquete>> offers, ArrayList<Paquete> packages){
        for(Oferta o : offers.keySet()) {
            double maxWeight = o.getPesomax();
            double currentWeight = 0;
            for(Paquete p : packages) {
                if(currentWeight + p.getPeso() <= maxWeight) {
                    offers.get(o).add(p);
                    currentWeight += p.getPeso();
                    packages.remove(p);
                }
            }
        }

        return offers;
    }
}