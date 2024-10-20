import IA.Azamon.Oferta;
import IA.Azamon.Paquete;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;

public class AzamonInitialSolution {

    public ArrayList<Integer> capacityFirstSolution(ArrayList<Oferta> offers, ArrayList<Paquete> packages) {
        packages.sort(Comparator.comparingDouble(Paquete::getPeso));
        return fillCapacity(offers, packages);
    }

    public ArrayList<Integer> priorityFirstSolution(ArrayList<Oferta> offers, ArrayList<Paquete> packages) {
        packages.sort(Comparator.comparingInt(Paquete::getPrioridad));
        return fillCapacity(offers, packages);
    }

    public ArrayList<Integer> randomSolution(ArrayList<Oferta> offers, ArrayList<Paquete> packages) {
        Collections.shuffle(packages);
        return fillCapacity(offers, packages);
    }

    private ArrayList<Integer> fillCapacity(ArrayList<Oferta> offers, ArrayList<Paquete> packages){
        ArrayList<Integer> result = new ArrayList<>();
        ArrayList<Paquete> temp = new ArrayList<>(packages);

        for(Oferta o : offers) {
            double maxWeight = o.getPesomax();
            double currentWeight = 0;
            Iterator<Paquete> iterator = temp.iterator();
            while (iterator.hasNext()) {
                Paquete p = iterator.next();
                if (currentWeight + p.getPeso() <= maxWeight) {
                    result.add(offers.indexOf(o));
                    currentWeight += p.getPeso();
                    iterator.remove();
                }
            }
        }

        return result;
    }
}