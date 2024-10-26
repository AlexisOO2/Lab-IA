import IA.Azamon.Oferta;
import IA.Azamon.Paquete;
import IA.Azamon.Transporte;
import IA.Azamon.Paquetes;
import java.util.ArrayList;

public class AzamonBoard {
  private Transporte trans;
  private Paquetes pakgs;
  int n_pckgs;
  int n_offers;
  ArrayList <Integer> assignment;
  Integer happiness;

  public AzamonBoard(ArrayList <Integer> prev_assigment, Transporte t, Paquetes p, Integer h){
    assignment = new ArrayList<> (prev_assigment);
    trans = t;
    pakgs = p;
    n_pckgs = pakgs.size();
    n_offers = trans.size();
    happiness = h;

  }

  // Get Functions//
  public int getN_packets(){
    return n_pckgs;
  }

  public int getN_offers(){
    return n_offers;
  }

  public ArrayList <Integer> getAssignment(){
    return assignment;
  }

  public Transporte getTrans() {
    return trans;
  }

  public Paquetes getPakgs() {
    return pakgs;
  }

  public Integer getHappiness() {
    return happiness;
  }

// Operators//
  public void move(int id_packet, int id_offer){
    assignment.set(id_packet,id_offer);
  }

  public void swap(int id_pckg1, int id_pckg2){
    int id_offer1 = assignment.get(id_pckg1);
    int id_offer2 = assignment.get(id_pckg2);

    assignment.set(id_pckg1,id_offer2);
    assignment.set(id_pckg2,id_offer1);
  }
  
  public void pour(int id_offer){
    while (assignment.contains(id_offer)){
      int i = assignment.indexOf(id_offer);
      assignment.set(i, null);
    }
  }

  public void swap_offers(int id_offer1,int id_offer2){
    for (int i = 0; i < n_pckgs; i++){
      int id = assignment.get(i);
      if (id == id_offer1) assignment.set(i,id_offer2);
      else if (id == id_offer2) assignment.set(i,id_offer1);
    }
  }

  @Override
  public String toString(){
    StringBuilder s = new StringBuilder();
    for (int i = 0; i < assignment.size(); i++ ) {
      s.append(i);
      s.append(" -> ");
      s.append(assignment.get(i));
      s.append("; ");
    }
    s.append("\n");
    return s.toString();
  }

  public void printCostsAndHappiness() {
    double totalCost = 0;
    int totalHappiness = 0;

    for (int i = 0; i < assignment.size(); i++) {
      Paquete p = pakgs.get(i); // Paquete
      if (assignment.get(i) != null) {
        Oferta o = trans.get(assignment.get(i)); // Oferta

        int packageDays = getMaxDaysForPriority(p.getPrioridad()); // Prioridad del paquete
        int offerDays = o.getDias(); // Días de la oferta

        if (offerDays <= packageDays) {
          totalCost += p.getPeso() * (o.getPrecio() + p.getPrioridad() * 0.25); // peso * ( euro / kilo + dia * euro / dia * kilo)
          totalHappiness += packageDays - offerDays;
        } else {
          totalCost += 9999; // Penalización
        }
      } else {
        totalCost += 1000; // Penalización por no asignar
      }
    }

    // Imprimir costes y felicidad
    System.out.println("Total cost = " + totalCost + "€");
    System.out.println("Happiness points = " + totalHappiness);
  }

  private int getMaxDaysForPriority(int priority) {
    switch(priority) {
      case 0: return 1;  // Prioridad 0: Entrega al día siguiente
      case 1: return 3;  // Prioridad 1: Entrega en 2 o 3 días
      case 2: return 5;  // Prioridad 2: Entrega en 4 o 5 días
      default: return -1;  // Cualquier otro caso se considerara negativo
    }
  }

}



