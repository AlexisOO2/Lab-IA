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
}



