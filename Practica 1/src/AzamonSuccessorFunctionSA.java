import aima.search.framework.Successor;
import aima.search.framework.SuccessorFunction;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class AzamonSuccessorFunctionSA implements SuccessorFunction {
    Operation operation;

    public AzamonSuccessorFunctionSA(Operation operation) {
        this.operation = operation;
    }

    public List<Successor> getSuccessors(Object aState) {
        List<Successor> retVal = new ArrayList<>();
        AzamonBoard board  = (AzamonBoard) aState;
        AzamonHeuristicFunction AHF = new AzamonHeuristicFunction();
        int i,j;
        Random rand = new Random();

        i=rand.nextInt(board.getN_packets());
        j=rand.nextInt(board.getN_offers());

        AzamonBoard newBoard = new AzamonBoard(board.getAssignment(), board.getTrans(), board.getPakgs());
        String S = "";
        switch (operation) {
            case MOVE: {
                newBoard.move(i,j);
                double v = AHF.getHeuristicValue(newBoard);
                S = "Move packet(" + i + ") to offer (" + j + ") Cost =" + v + ") ---> " + newBoard.toString();
                break;
            }
            case MOVE_AND_SWAP: {
                break;
            }
            case MOVE_AND_POUR: {
                break;
            }
            case MOVE_SWAP_AND_POUR: {
                break;
            }
            default: {  // Move
                newBoard.move(i,j);
                double v = AHF.getHeuristicValue(newBoard);
                S = "Move packet(" + i + ") to offer (" + j + ") Cost =" + v + ") ---> " + newBoard.toString();
                break;
            }
        }

        retVal.add(new Successor(S, newBoard));
        return retVal;
    }
}
