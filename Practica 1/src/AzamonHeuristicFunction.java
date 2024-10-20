import IA.Azamon.Oferta;
import IA.Azamon.Paquete;
import aima.search.framework.HeuristicFunction;

import java.util.ArrayList;

public class AzamonHeuristicFunction implements HeuristicFunction {

    public boolean equals(Object obj) {
        boolean retValue;

        retValue = super.equals(obj);
        return retValue;
    }

    public double getHeuristicValue(Object state) {
        AzamonBoard board = (AzamonBoard) state;
        double totalCost = 0;
        int totalHappiness = 0;
        ArrayList<Paquete> packages = board.getPakgs();
        ArrayList<Oferta> transports = board.getTrans();
        ArrayList<Integer> assignment = board.getAssignment();

        for (int i = 0; i < assignment.size(); i++) {
            Paquete p = packages.get(i);     // Paquete
            Oferta o = transports.get(assignment.get(i));   // Oferta

            totalCost += o.getPrecio() * p.getPeso();

            int packageDays = getMaxDaysForPriority(p.getPrioridad());  // Prioridad del paquete
            int offerDays = o.getDias();    // Prioridad de la oferta

            if (offerDays < packageDays) {
                totalHappiness += packageDays - offerDays;
            }
        }

        //Variables para regular la prioridad del dato en el calculo
        int a = 1;
        int b = 1;

        return (a * totalCost) - (b * totalHappiness);
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