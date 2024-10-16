import IA.Azamon.Oferta;
import IA.Azamon.Paquete;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class AzamonInitialSolution {

    public ArrayList<Object> capacityFirstSolution(ArrayList<Oferta> offers, ArrayList<Paquete> packages) {
        packages.sort(Comparator.comparingDouble(Paquete::getPeso));
        return fillCapacity(offers, packages);
    }

    public ArrayList<Object> priorityFirstSolution(ArrayList<Oferta> offers, ArrayList<Paquete> packages) {
        packages.sort(Comparator.comparingInt(Paquete::getPrioridad));
        return fillCapacity(offers, packages);
    }

    public ArrayList<Object> randomSolution(ArrayList<Oferta> offers, ArrayList<Paquete> packages) {
        Collections.shuffle(packages);
        return fillCapacity(offers, packages);
    }

    private ArrayList<Object> fillCapacity(ArrayList<Oferta> offers, ArrayList<Paquete> packages){
        ArrayList<Object> result = new ArrayList<>();

        for(Oferta o : offers) {
            double maxWeight = o.getPesomax();
            double currentWeight = 0;
            for(Paquete p : packages) {
                if(currentWeight + p.getPeso() <= maxWeight) {
                    result.add(p);
                    result.add(o);
                    currentWeight += p.getPeso();
                    packages.remove(p);
                }
            }
        }

        return result;
    }
}