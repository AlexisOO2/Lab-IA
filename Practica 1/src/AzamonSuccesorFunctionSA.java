import aima.search.framework.Successor;
import aima.search.framework.SuccessorFunction;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class AzamonSuccessorFunctionSA implements SuccessorFunction {
    public List getSuccessors(Object aState) {
        ArrayList retVal = new ArrayList();
        AzamonBoard board  = (AzamonBoard) aState;
        AzamonHeuristicFunction AHF = new AzamonSuccessorFunction();
        int i,j;
        Random rand = new Random();

        i=rand.nextInt(board.getN_packets());
        j=rand.nextInt(board.getN_offers());

        AzamonBoard newBoard = new AzamonBoard(board.getN_packets(), board.getN_offers(), board.getAssigment());
        newBoard.move(i,j);

        double v = 0.0; // = APHF.getHeuristicValue(newBoard);
        String S = "Move packet(" + i + ") to offer (" + j + ") Cost =" + v + ") ---> " + newBoard.toString();

        retVal.add(new Successor(S, newBoard));
        return retVal;
    }
}
