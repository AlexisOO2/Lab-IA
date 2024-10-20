import aima.search.framework.Successor;
import aima.search.framework.SuccessorFunction;
import java.util.ArrayList;
import java.util.List;

public class AzamonSuccessorFunction implements SuccessorFunction {
    public List getSuccessors(Object aState) {
        ArrayList retVal = new ArrayList();
        AzamonBoard board  = (AzamonBoard) aState;

        AzamonHeuristicFunction AHF = new AzamonSuccessorFunction();

        for (int i = 0; i <  board.getN_packets(); i++) {
            for (int j = 0; j < board.getN_offers(); j++) {
                AzamonBoard newBoard = new AzamonBoard(board.getAssigment(), board.getTrans(), board.getPakgs());
                newBoard.move(i,j);

                double v = 0.0; // = APHF.getHeuristicValue(newBoard);
                String S = "Move packet(" + i + ") to offer (" + j + ") Cost =" + v + ") ---> " + newBoard.toString();
                retVal.add(new Successor(S, newBoard));
            }
        }
        return retVal;
    }
}