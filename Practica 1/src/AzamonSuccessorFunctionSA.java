import aima.search.framework.Successor;
import aima.search.framework.SuccessorFunction;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class AzamonSuccessorFunctionSA implements SuccessorFunction {
    public List<Successor> getSuccessors(Object aState) {
        List<Successor> retVal = new ArrayList<>();
        AzamonBoard board  = (AzamonBoard) aState;
        AzamonHeuristicFunction AHF = new AzamonHeuristicFunction();
        int i,j;
        Random rand = new Random();

        i=rand.nextInt(board.getN_packets());
        j=rand.nextInt(board.getN_offers());

        AzamonBoard newBoard = new AzamonBoard(board.getAssignment(), board.getTrans(), board.getPakgs());
        newBoard.move(i,j);

        double v = AHF.getHeuristicValue(newBoard);
        String S = "Move packet(" + i + ") to offer (" + j + ") Cost =" + v + ") ---> " + newBoard.toString();

        retVal.add(new Successor(S, newBoard));
        return retVal;
    }
}
