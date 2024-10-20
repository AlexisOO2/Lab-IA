import IA.Azamon.Transporte;
import IA.Azamon.Paquetes;
import java.util.ArrayList;

public class AzamonBoard {
  private Transporte trans;
  private Paquetes pakgs;
  int n_pckgs;
  int n_offers;
  ArrayList <int> assigment;

  public AzamonBoard(ArrayList <int> prev_assigment, Transporte t, Paquetes p){
    assigment = new ArrayList<Object> (prev_assigment);
    trans = t;
    pakgs = p;
    n_pckgs = pakgs.size();
    n_offers = trans.size();
  }

  // Get Functions//
  public int getN_packets(){
    return n_pckgs;
  }

  public int getN_offers(){
    return n_offers;
  }

  public ArrayList <int> getAssigment(){
    return assigment;
  }

  public Transporte getTrans() {
    return trans;
  }

  public Paquetes getPakgs() {
    return pakgs;
  }

// Operators//
  public void move(int id_packet, int id_offer){
    assigment.set(id_packet,id_offer);
  }

  public void swap(int id_pckg1, int id_pckg2){
    int id_offer1 = assigment.get(id_pckg1);
    int id_offer2 = assigment.get(id_pckg2);

    assigment.set(id_pckg1,id_offer2);
    assigment.set(id_pckg2,id_offer1);
  }
  
  public void pour(int id_offer){
    while (assigment.contains(id_offer)){
      int i = assigment.indexOf(id_offer);
      assigment.set(i, null);
    }
  }

  //        //
  public String toString(){
    String s;
    for (int i = 0; i < assigment.size(); i++ ){
      s += i + " -> " + assigment.get(i) + "; " ;
    }
    s += "\n";
    return s;
  }
}



