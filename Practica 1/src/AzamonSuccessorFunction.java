import aima.search.framework.Successor;
import aima.search.framework.SuccessorFunction;
import java.util.ArrayList;
import java.util.List;

public class AzamonSuccessorFunction implements SuccessorFunction {
    public List<Successor> getSuccessors(Object aState) {
        List<Successor> retVal = new ArrayList<>();
        AzamonBoard board  = (AzamonBoard) aState;

        AzamonHeuristicFunction AHF = new AzamonHeuristicFunction();

        for (int i = 0; i <  board.getN_packets(); i++) {
            for (int j = 0; j < board.getN_offers(); j++) {
                AzamonBoard newBoard = new AzamonBoard(board.getAssignment(), board.getTrans(), board.getPakgs());
                newBoard.move(i,j);

                double v = AHF.getHeuristicValue(newBoard);
                String S = "Move packet(" + i + ") to offer (" + j + ") Cost =" + v + ") ---> " + newBoard.toString();
                retVal.add(new Successor(S, newBoard));
            }
        }
        return retVal;
    }
}