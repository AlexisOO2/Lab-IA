import IA.Azamon.Oferta;
import IA.Azamon.Paquete;
import aima.search.framework.HeuristicFunction;

import java.util.ArrayList;

public class AzamonHeuristicFunction implements HeuristicFunction {
    double totalCost;
    int penalization;
    int totalHappiness;
    public boolean equals(Object obj) {
        boolean retValue;

        retValue = super.equals(obj);
        return retValue;
    }

    public double getHeuristicValue(Object state) {
         totalCost = 0;
         penalization = 0;
         totalHappiness = 0;
        AzamonBoard board = (AzamonBoard) state;
        ArrayList<Paquete> packages = board.getPakgs();
        ArrayList<Oferta> transports = board.getTrans();
        ArrayList<Integer> assignment = board.getAssignment();
        for (int i = 0; i < assignment.size(); i++) {
            Paquete p = packages.get(i);     // Paquete
            if (assignment.get(i) != null) {
                Oferta o = transports.get(assignment.get(i));   // Oferta

                int packageDays = getMaxDaysForPriority(p.getPrioridad());  // Prioridad del paquete
                int offerDays = o.getDias();    // Prioridad de la oferta

                if (offerDays <= packageDays) {
                    totalCost += (p.getPeso() * o.getPrecio());
                    if (offerDays == 3 || offerDays == 4){
                        totalCost += (p.getPeso() * 0.25);
                    }
                    else if (offerDays == 5){
                        totalCost += (p.getPeso() * 2 * 0.25);
                    }
                    // peso * ( euro / kilo + dia * euro / dia * kilo)
                    totalHappiness += packageDays - offerDays;
                }
                 else {
                    penalization += 9999;
                }
            } else {
                penalization += 1000;
            }
        }

        //Variables para regular la prioridad del dato en el calculo
        double a = 1;
        double b = board.getHappiness();;
        int c = board.getHappiness();

        //System.out.println("Total cost = " + totalCost + "€ \nHappiness points = " + totalHappiness + "\n");

        return (a * totalCost) + penalization - (b * c * totalHappiness);
    }

    public double getTotalCost(){
        return totalCost;
    }

    public int getHappiness(){
        return totalHappiness;
    }

    // Método auxiliar para obtener el número máximo de días que corresponde a una prioridad de paquete
    private int getMaxDaysForPriority(int priority) {
        switch(priority) {
            case 0: return 1;  // Prioridad 0: Entrega al día siguiente
            case 1: return 3;  // Prioridad 1: Entrega en 2 o 3 días
            case 2: return 5;  // Prioridad 2: Entrega en 4 o 5 días
            default: return -1;  // Cualquier otro caso se considerara negativo
        }
    }
}