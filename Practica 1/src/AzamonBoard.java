import IA.Azamon.Oferta;
import IA.Azamon.Paquete;
import java.util.ArrayList;

public class AzamonBoard {

  ArrayList <Object> assigment;

  public AzamonBoard(ArrayList <Object> prev_assigment){
    assigment = new ArrayList<Object> (prev_assigment);
  }
  
  public void move(Paquete p, Oferta o){
    int i = assigment.indexOf(p);
    assigment.set(i+1,o);
  }

  public void swap(Paquete p1, Paquete p2){
    int i = assigment.indexOf(p1);
    int j = assigment.indexOf(p2);

    assigment.set(i,p2);
    assigment.set(j,p1);
  }
  
  public void pour(Oferta o){
    while (assigment.contains(o)){
      int i = assigment.indexOf(o);
      assigment.set(i, null);
    }
  }
}



